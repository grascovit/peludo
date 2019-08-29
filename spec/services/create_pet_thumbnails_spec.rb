# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePetThumbnails, type: :service do
  describe '#call' do
    subject(:call_service) { described_class.new(pet).call }

    let(:pet) { create(:pet) }

    it 'generates thumbnails for pet pictures' do
      call_service

      expect(pet.thumbnails.collect(&:class).uniq).to eq([ActiveStorage::Variant])
    end

    it 'updates the pet state to processed' do
      expect do
        call_service
        pet.reload
      end.to change(pet, :state).from('unprocessed').to('processed')
    end
  end
end
