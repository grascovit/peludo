# frozen_string_literal: true

class PetDecorator < Draper::Decorator
  delegate_all

  include Rails.application.routes.url_helpers

  def safe_name
    object.name.presence || I18n.t('shared.pet_details.no_name_informed')
  end

  def safe_age
    object.age.presence || I18n.t('shared.pet_details.no_age_informed')
  end

  def safe_breed
    object.breed ? object.breed.name : I18n.t('shared.pet_details.no_breed_informed')
  end

  def safe_gender
    if object.gender.present?
      I18n.t("activerecord.attributes.pet.genders.#{object.gender}")
    else
      I18n.t('shared.pet_details.no_gender_informed')
    end
  end

  def safe_description
    object.description.presence || I18n.t('shared.pet_details.no_description_given')
  end

  def picture_url
    h.url_for(object.thumbnails.first)
  end

  def path
    case object.situation.to_sym
    when :lost
      lost_pet_path(object)
    when :found
      found_pet_path(object)
    when :for_adoption
      pet_for_adoption_path(object)
    end
  end
end
