# frozen_string_literal: true

class PetDecorator < Draper::Decorator
  delegate_all

  def safe_name
    object.name.presence || I18n.t('lost_pets.show.no_name_informed')
  end

  def safe_breed
    object.breed ? object.breed.name : I18n.t('lost_pets.shared.no_breed_informed')
  end

  def safe_gender
    if object.gender.present?
      I18n.t("activerecord.attributes.pet.genders.#{object.gender}")
    else
      I18n.t('lost_pets.show.no_gender_informed')
    end
  end

  def safe_description
    object.description.presence || I18n.t('lost_pets.show.no_description_given')
  end

  def picture_url
    h.url_for(object.pictures.first)
  end
end
