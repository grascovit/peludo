# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:breed).optional }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_numericality_of(:age).only_integer }
    it { is_expected.to validate_presence_of(:situation) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to define_enum_for(:gender).with_values(%i[female male]) }
    it { is_expected.to define_enum_for(:situation).with_values(%i[found lost]) }

    context 'when pet is lost' do
      subject { build_stubbed(:pet, situation: :lost) }

      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:breed) }
      it { is_expected.to validate_presence_of(:gender) }
    end
  end

  describe 'scopes' do
    describe 'default scope' do
      it 'returns only active pets' do
        active_pet = create(:pet, deactivated_at: nil)
        create(:pet, deactivated_at: 1.day.ago)

        expect(described_class.all).to match_array([active_pet])
      end
    end

    describe '.with_deactivated' do
      it 'returns active and deactivated pets' do
        active_pet = create(:pet, deactivated_at: nil)
        deactivated_pet = create(:pet, deactivated_at: 1.day.ago)

        expect(described_class.with_deactivated).to match_array([active_pet, deactivated_pet])
      end
    end
  end

  describe '.genders_for_select' do
    it 'returns genders' do
      expect(described_class.genders_for_select).to eq(
        [
          [I18n.t('activerecord.attributes.pet.genders.female').to_s, 'female'],
          [I18n.t('activerecord.attributes.pet.genders.male').to_s, 'male']
        ]
      )
    end
  end
end
