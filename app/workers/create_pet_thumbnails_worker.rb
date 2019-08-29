# frozen_string_literal: true

class CreatePetThumbnailsWorker
  include Sidekiq::Worker

  def perform(pet_id)
    pet = Pet.find(pet_id)

    CreatePetThumbnails.new(pet).call
  end
end
