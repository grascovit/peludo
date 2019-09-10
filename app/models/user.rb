# frozen_string_literal: true

class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :omniauthable

  has_many :pets

  validates :first_name, :phone_number, presence: true

  def deactivate!
    update(deactivated_at: Time.current)
    update_pets(deactivated_at: Time.current)
  end

  def reactivate!
    return unless deactivated_at?

    update(deactivated_at: nil)
    update_pets(deactivated_at: nil)
  end

  private

  def update_pets(**attributes)
    pets.with_deactivated.each do |pet|
      pet.update(attributes)
    end
  end
end
