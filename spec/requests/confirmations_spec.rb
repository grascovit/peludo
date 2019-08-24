# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Confirmations', type: :request do
  let!(:user) { create(:user) }

  describe 'GET #show' do
    subject(:confirm_user) do
      get user_confirmation_path, params: { confirmation_token: user.confirmation_token }
    end

    it 'confirms that user was signed in after confirmation' do
      expect do
        confirm_user
        user.reload
      end.to change(user, :sign_in_count).by(1)
    end

    it 'redirects to the home page after confirmation' do
      confirm_user

      expect(response).to redirect_to(home_path)
    end
  end
end
