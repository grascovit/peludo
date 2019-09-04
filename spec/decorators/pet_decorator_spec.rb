# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PetDecorator do
  describe '#safe_name' do
    subject { pet.safe_name }

    let(:pet) { build_stubbed(:pet, name: name).decorate }

    context 'when pet has a name' do
      let(:name) { 'Rex' }

      it { is_expected.to eq('Rex') }
    end

    context 'when pet has no name' do
      let(:name) { '' }

      it { is_expected.to eq(I18n.t('shared.pet_details.no_name_informed')) }
    end
  end

  describe '#safe_breed' do
    subject { pet.safe_breed }

    let(:pet) { build_stubbed(:pet, breed: breed).decorate }

    context 'when pet has a breed' do
      let(:breed) { build_stubbed(:breed, name: 'Dachshund') }

      it { is_expected.to eq('Dachshund') }
    end

    context "when pet doesn't have a breed" do
      let(:breed) { nil }

      it { is_expected.to eq(I18n.t('shared.pet_details.no_breed_informed')) }
    end
  end

  describe '#safe_gender' do
    subject { pet.safe_gender }

    let(:pet) { build_stubbed(:pet, gender: gender).decorate }

    context 'when pet has a gender' do
      let(:gender) { 'male' }

      it { is_expected.to eq(I18n.t('activerecord.attributes.pet.genders.male')) }
    end

    context 'when pet has no gender' do
      let(:gender) { '' }

      it { is_expected.to eq(I18n.t('shared.pet_details.no_gender_informed')) }
    end
  end

  describe '#safe_description' do
    subject { pet.safe_description }

    let(:pet) { build_stubbed(:pet, description: description).decorate }

    context 'when pet has a description' do
      let(:description) { 'Description' }

      it { is_expected.to eq('Description') }
    end

    context 'when pet has no description' do
      let(:description) { '' }

      it { is_expected.to eq(I18n.t('shared.pet_details.no_description_given')) }
    end
  end

  describe '#picture_url' do
    subject(:pet_picture_url) { pet.picture_url }

    let(:pet) { create(:pet).decorate }

    it 'returns the first picture url' do
      expect(pet_picture_url).to eq(helper.url_for(pet.pictures.first))
    end
  end
end
