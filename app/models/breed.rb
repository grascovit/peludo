# frozen_string_literal: true

class Breed < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :sorted_by_name, ->(order) { order(name: order) }

  def self.for_select
    sorted_by_name(:asc).pluck(:name, :id)
  end
end
