# frozen_string_literal: true

class PetDecorator < Draper::Decorator
  delegate_all

  def breed
    object.breed ? object.breed.name : I18n.t('lost_pets.shared.no_breed_informed')
  end

  def picture_url
    h.url_for(object.pictures.first)
  end
end
