# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreatePetThumbnailsWorker, type: :worker do
  subject(:call_worker) { described_class.new.perform(pet.id) }

  let(:pet) { create(:pet) }
  let(:service) { instance_double(CreatePetThumbnails) }

  describe '#perform' do
    it 'calls service to create the pet thumbnails' do
      allow(CreatePetThumbnails).to receive(:new).with(pet).and_return(service)
      allow(service).to receive(:call)

      call_worker

      expect(service).to have_received(:call)
    end
  end
end
