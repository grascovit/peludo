# frozen_string_literal: true

FactoryBot.define do
  factory :breed do
    name { Faker::Creature::Dog.breed }
  end
end
