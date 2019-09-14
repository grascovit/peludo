# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PetDecorator, type: :decorator do
  include Rails.application.routes.url_helpers

  describe '#safe_name' do
    subject { pet.decorate.safe_name }

    let(:pet) { build_stubbed(:pet, name: name) }

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
    subject { pet.decorate.safe_breed }

    let(:pet) { build_stubbed(:pet, breed: breed) }

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
    subject { pet.decorate.safe_gender }

    let(:pet) { build_stubbed(:pet, gender: gender) }

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
    subject { pet.decorate.safe_description }

    let(:pet) { build_stubbed(:pet, description: description) }

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
    subject(:pet_picture_url) { pet.decorate.picture_url }

    let(:pet) { create(:pet) }

    it 'returns the first picture url' do
      expect(pet_picture_url).to eq(helper.url_for(pet.pictures.first))
    end
  end

  describe '#path' do
    subject(:pet_path) { pet.decorate.path }

    context 'when its a lost pet' do
      let(:pet) { create(:pet, situation: :lost) }

      it 'returns the path to lost pet page' do
        expect(pet_path).to eq(lost_pet_path(pet))
      end
    end

    context 'when its a found pet' do
      let(:pet) { create(:pet, situation: :found) }

      it 'returns the path to lost pet page' do
        expect(pet_path).to eq(found_pet_path(pet))
      end

      context 'when its a pet for adoption' do
        let(:pet) { create(:pet, situation: :for_adoption) }

        it 'returns the path to lost pet page' do
          expect(pet_path).to eq(pet_for_adoption_path(pet))
        end
      end
    end
  end
end
