# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable

  has_many :lost_pets, class_name: 'Pet', foreign_key: :user_id
  has_many :found_pets, class_name: 'Pet', foreign_key: :user_id

  validates :first_name, :phone_number, presence: true
end
