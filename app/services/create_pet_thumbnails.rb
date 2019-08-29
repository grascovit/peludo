# frozen_string_literal: true

class CreatePetThumbnails
  THUMBNAIL_TRANSFORMATION = { resize: '320x320' }.freeze

  attr_reader :pet

  def initialize(pet)
    @pet = pet
  end

  def call
    pet.pictures.each do |picture|
      picture.variant(THUMBNAIL_TRANSFORMATION).processed
    end

    pet.process
  end
end
