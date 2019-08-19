# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let!(:user) { create(:user, deactivated_at: 1.day.ago) }
  let!(:lost_pet) { create(:pet, user: user, situation: :lost, deactivated_at: 1.day.ago) }
  let!(:found_pet) { create(:pet, user: user, situation: :found, deactivated_at: 1.day.ago) }

  before do
    user.confirm
  end

  describe 'POST #create' do
    subject(:reactivate_user) do
      post user_session_path, params: params
    end

    context 'with valid params' do
      let(:params) do
        {
          user: {
            email: user.email,
            password: user.password
          }
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

      it 'redirects to the root page' do
        reactivate_user

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          user: {
            email: '',
            password: ''
          }
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

      it 'renders the login page again' do
        reactivate_user

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
