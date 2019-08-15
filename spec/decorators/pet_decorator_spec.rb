# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PetDecorator do
  describe '#breed' do
    subject { pet.breed }

    let(:pet) { build_stubbed(:pet, breed: breed).decorate }

    context 'when pet has a breed' do
      let(:breed) { build_stubbed(:breed, name: 'Dachshund') }

      it { is_expected.to eq('Dachshund') }
    end

    context "when pet doesn't have a breed" do
      let(:breed) { nil }

      it { is_expected.to eq(I18n.t('lost_pets.shared.no_breed_informed')) }
    end
  end

  describe '#picture_url' do
    subject(:pet_picture_url) { pet.picture_url }

    let(:pet) { create(:pet).decorate }

    context 'when there are multiple pictures' do
      let(:picture) { fixture_file_upload('/files/rails.png') }

      it 'returns the first picture url' do
        pet.pictures.attach(io: File.open(picture), filename: 'rails.png', content_type: 'image/png')

        expect(pet_picture_url).to eq(helper.url_for(pet.pictures.first))
      end
    end

    context 'when there are no pictures' do
      it 'raises error' do
        expect { pet_picture_url }.to raise_error(ActionController::UrlGenerationError)
      end
    end
  end
end
