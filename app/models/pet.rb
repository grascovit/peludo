# frozen_string_literal: true

class Pet < ApplicationRecord
  enum gender: %i[female male]
  enum situation: %i[found lost]

  belongs_to :breed, optional: true
  belongs_to :user
  has_many_attached :pictures

  validates :age, numericality: { only_integer: true }, allow_nil: true
  validates :situation, :city, :state, :country, presence: true

  def self.genders_for_select
    genders.keys.collect do |gender|
      [I18n.t("activerecord.attributes.pet.genders.#{gender}"), gender]
    end
  end
end