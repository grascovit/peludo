# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'Omniauth', type: :request do
      describe 'GET #google_oauth2' do
        subject(:oauth_user) do
          post api_v1_omniauth_google_oauth2_path, params: params
        end

        let(:params) do
          {
            id_token: 'eyJhbGciOiJub25lIn0.eyJlbWFpbCI6InRlc3RAdGVzdC5jb20iLCJnaXZlbl9uYW1lIjoiRmlyc3QiLCJmYW1pbHlfbm'\
                      'FtZSI6Ikxhc3QiLCJzdWIiOiJhMWIyYzMifQ.'
          }
        end

        context 'when user already exists' do
          let(:user) { create(:user, email: 'test@test.com') }

          it 'returns http success' do
            oauth_user

            expect(response).to have_http_status(:ok)
          end

          it 'returns the existing user' do
            oauth_user

            expect(response).to match_json_schema('v1/omniauth_user')
          end
        end

        context "when user doesn't exist yet" do
          it 'creates the user' do
            expect do
              oauth_user
            end.to change(User, :count).by(1)
          end

          it 'returns the created user' do
            oauth_user

            expect(response).to match_json_schema('v1/omniauth_user')
          end
        end

        context 'when id_token is not a valid jwt' do
          let(:params) do
            {
              id_token: '123'
            }
          end

          it 'does not create the user' do
            expect do
              oauth_user
            end.not_to change(User, :count)
          end

          it 'returns bad request status' do
            oauth_user

            expect(response).to have_http_status(:bad_request)
          end
        end

        context 'when id_token contains invalid information' do
          let(:params) do
            {
              id_token: 'eyJhbGciOiJub25lIn0.eyJlbWFpbCI6IiIsImdpdmVuX25hbWUiOiIiLCJmYW1pbHlfbmFtZSI6Ikxhc3QiLCJzdWIi'\
                        'OiJhMWIyYzMifQ.'
            }
          end

          it 'does not create the user' do
            expect do
              oauth_user
            end.not_to change(User, :count)
          end

          it 'returns unprocessable entity status' do
            oauth_user

            expect(response).to have_http_status(:unprocessable_entity)
          end

          it 'returns the errors messages' do
            oauth_user

            expect(JSON.parse(response.body)).to eq(
              [
                'Nome não pode ficar em branco'
              ]
            )
          end
        end
      end
    end
  end
end
