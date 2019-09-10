# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:pets) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:phone_number) }
  end

  describe '#deactivate!' do
    subject(:deactivate_user) { user.deactivate! }

    let!(:user) { create(:user, deactivated_at: nil) }
    let!(:lost_pet) { create(:pet, user: user, situation: :lost, deactivated_at: nil) }
    let!(:found_pet) { create(:pet, user: user, situation: :found, deactivated_at: nil) }

    it 'deactivates the user' do
      deactivate_user

      expect(user.deactivated_at).not_to be_nil
    end

    it 'deactivates pets registered by user' do
      deactivate_user
      lost_pet.reload
      found_pet.reload

      expect(lost_pet.deactivated_at).not_to be_nil
      expect(found_pet.deactivated_at).not_to be_nil
    end
  end

  describe '#reactivate!' do
    subject(:reactivate_user) { user.reactivate! }

    let!(:lost_pet) { create(:pet, user: user, situation: :lost, deactivated_at: 1.day.ago) }
    let!(:found_pet) { create(:pet, user: user, situation: :found, deactivated_at: 1.day.ago) }

    context 'when user is deactivated' do
      let(:user) { create(:user, deactivated_at: 1.day.ago) }

      it 'reactivates the user' do
        reactivate_user

        expect(user.deactivated_at).to be_nil
      end

      it 'reactivates pets registered by user' do
        reactivate_user
        lost_pet.reload
        found_pet.reload

        expect(lost_pet.deactivated_at).to be_nil
        expect(found_pet.deactivated_at).to be_nil
      end
    end

    context 'when user is not deactivated' do
      let(:user) { create(:user, deactivated_at: nil) }

      it { is_expected.to be_nil }
    end
  end
end
