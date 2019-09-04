# frozen_string_literal: true

class Breed < ApplicationRecord
  has_many :pets

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :sorted_by_name, ->(order) { order(name: order) }

  def self.for_select(pet_situation:)
    includes(:pets)
      .where(pets: { situation: pet_situation })
      .sorted_by_name(:asc)
      .pluck(:name, :id)
  end
end
