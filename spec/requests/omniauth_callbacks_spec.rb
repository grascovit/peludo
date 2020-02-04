# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'OmniauthCallbacks', type: :request do
  describe 'GET #google_oauth2' do
    subject(:oauth_user) do
      get user_google_oauth2_omniauth_callback_path
    end

    let(:params) do
      OmniAuth::AuthHash.new(
        uid: '123',
        provider: 'google_oauth2',
        info: {
          first_name: 'First name',
          last_name: 'Last name',
          email: 'user@email.com'
        }
      )
    end

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = params
    end

    context 'when user already exists' do
      let(:user) { create(:user, email: 'user@email.com') }

      it 'redirects to the root page' do
        oauth_user

        expect(response).to redirect_to(root_path)
      end
    end

    context "when user doesn't exist yet" do
      it 'creates the user' do
        expect do
          oauth_user
        end.to change(User, :count).by(1)
      end

      it 'redirects to the root page' do
        oauth_user

        expect(response).to redirect_to(root_path)
      end
    end

    context 'when params are invalid' do
      let(:params) do
        OmniAuth::AuthHash.new(
          uid: '123',
          provider: 'google_oauth2',
          info: {
            first_name: '',
            last_name: '',
            email: ''
          }
        )
      end

      it 'does not create the user' do
        expect do
          oauth_user
        end.not_to change(User, :count)
      end

      it 'redirects to the sign in page' do
        oauth_user

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
