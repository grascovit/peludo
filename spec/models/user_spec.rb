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

  describe '.from_omniauth' do
    subject(:user_from_omniauth) { described_class.from_omniauth(auth_params) }

    let(:auth_params) do
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

    context 'when user already exists' do
      let!(:user) { create(:user, email: 'user@email.com') }

      it 'returns the existing user' do
        expect(user_from_omniauth).to eq(user)
      end
    end

    context "when user doesn't exist yet" do
      it 'creates the user' do
        expect do
          user_from_omniauth
        end.to change(described_class, :count).by(1)
      end

      it 'returns the created user' do
        expect(user_from_omniauth).to eq(described_class.last)
      end
    end
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

  describe '#omniauth?' do
    subject { user.omniauth? }

    context 'when provider is included in omniauth providers' do
      let(:user) { build_stubbed(:user, provider: 'google_oauth2') }

      it { is_expected.to be_truthy }
    end

    context 'when provider is not included in omniauth providers' do
      let(:user) { build_stubbed(:user, provider: 'email') }

      it { is_expected.to be_falsey }
    end
  end
end
