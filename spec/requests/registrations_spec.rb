# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Registrations', type: :request do
  let!(:user) { create(:user) }
  let!(:lost_pet) { create(:pet, user: user, situation: :lost, deactivated_at: nil) }
  let!(:found_pet) { create(:pet, user: user, situation: :found, deactivated_at: nil) }

  before do
    user.confirm
    sign_in(user)
  end

  describe 'DELETE #destroy' do
    subject(:deactivate_user) do
      delete user_registration_path, params: { id: user.id }
    end

    it 'deactivates user and his/her registered pets' do
      deactivate_user
      lost_pet.reload
      found_pet.reload

      expect(user.deactivated_at).not_to be_nil
      expect(lost_pet.deactivated_at).not_to be_nil
      expect(found_pet.deactivated_at).not_to be_nil
    end

    it 'redirects to the root page' do
      deactivate_user

      expect(response).to redirect_to(root_path)
    end
  end
end
