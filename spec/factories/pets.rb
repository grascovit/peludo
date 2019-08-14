# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    age { Faker::Creature::Dog.age.to_i }
    gender { Pet.genders.keys.sample }
    description { Faker::Lorem.paragraph }
    situation { Pet.situations.keys.sample }
    city { Faker::Address.city }
    state { Faker::Address.state }
    country { Faker::Address.country }
    breed
    user
  end
end
