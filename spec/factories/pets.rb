# frozen_string_literal: true

FactoryBot.define do
  factory :pet do
    name { Faker::Creature::Dog.name }
    age { rand(1..15) }
    gender { Pet.genders.keys.sample }
    description { Faker::Lorem.paragraphs }
    situation { Pet.situations.keys.sample }
    address { Faker::Address.full_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    breed { Breed.find_or_initialize_by(name: Faker::Creature::Dog.breed) }
    user
    pictures do
      [
        Rack::Test::UploadedFile.new('spec/fixtures/files/placeholder.png', 'image/png'),
        Rack::Test::UploadedFile.new('spec/fixtures/files/placeholder.png', 'image/png')
      ]
    end
  end
end
