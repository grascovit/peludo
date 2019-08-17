# frozen_string_literal: true

FactoryBot.define do
  factory :contact_log do
    association :requesting_user, factory: :user
    association :requested_user, factory: :user
    pet
  end
end
