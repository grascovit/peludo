# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'Sessions', type: :request do
      let!(:user) { create(:user, deactivated_at: 1.day.ago) }
      let!(:lost_pet) { create(:pet, user: user, situation: :lost, deactivated_at: 1.day.ago) }
      let!(:found_pet) { create(:pet, user: user, situation: :found, deactivated_at: 1.day.ago) }

      before do
        user.confirm
      end

      describe 'POST #create' do
        subject(:reactivate_user) do
          post new_api_v1_user_session_path, params: params
        end

        context 'with valid params' do
          let(:params) do
            {
              email: user.email,
              password: user.password
            }
          end

          it 'reactivates user and his/her registered pets' do
            reactivate_user
            user.reload
            lost_pet.reload
            found_pet.reload

            expect(user.deactivated_at).to be_nil
            expect(lost_pet.deactivated_at).to be_nil
            expect(found_pet.deactivated_at).to be_nil
          end

          it 'returns http success' do
            reactivate_user

            expect(response).to have_http_status(:ok)
          end

          it 'returns user data' do
            reactivate_user

            expect(response).to match_json_schema('v1/session')
          end
        end

        context 'with invalid params' do
          let(:params) do
            {
              email: '',
              password: ''
            }
          end

          it 'does not reactivate user and his/her registered pets' do
            reactivate_user
            user.reload
            lost_pet.reload
            found_pet.reload

            expect(user.deactivated_at).not_to be_nil
            expect(lost_pet.deactivated_at).not_to be_nil
            expect(found_pet.deactivated_at).not_to be_nil
          end

          it 'returns unauthorized http status' do
            reactivate_user

            expect(response).to have_http_status(:unauthorized)
          end

          it 'returns error message' do
            reactivate_user

            expect(JSON.parse(response.body)).to eq(
              'success' => false,
              'errors' => [
                I18n.t('devise_token_auth.sessions.bad_credentials')
              ]
            )
          end
        end
      end
    end
  end
end
