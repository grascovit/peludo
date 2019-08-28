# frozen_string_literal: true

class CreateThumbnailsWorker
  include Sidekiq::Worker

  THUMBNAIL_TRANSFORMATION = { resize: '320x320' }.freeze

  def perform(pet_id)
    pet = Pet.find(pet_id)

    pet.pictures.each do |picture|
      picture.variant(THUMBNAIL_TRANSFORMATION).processed
    end

    pet.process
  end
end
