# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    subject(:user) { build_stubbed(:user) }

    it do
      expect(user).to have_many(:found_pets)
        .class_name('Pet')
        .with_foreign_key(:user_id)
    end
    it do
      expect(user).to have_many(:lost_pets)
        .class_name('Pet')
        .with_foreign_key(:user_id)
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:phone_number) }
  end
end
