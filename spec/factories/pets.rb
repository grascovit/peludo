# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    age { Faker::Creature::Dog.age.to_i }
    gender { Pet.genders.keys.sample }
    description { Faker::Lorem.paragraph }
    situation { Pet.situations.keys.sample }
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    breed { |breed| Breed.find_or_initialize_by(name: breed.name) }
    user
  end
end
