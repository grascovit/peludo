# frozen_string_literal: true

FactoryBot.define do
  factory :breed do
    name { Faker::Creature::Dog.breed }

    initialize_with { Breed.find_or_initialize_by(name: name) }
  end
end
