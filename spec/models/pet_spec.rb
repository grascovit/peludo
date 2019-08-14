# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:breed).optional }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:situation) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_numericality_of(:age).only_integer }
    it { is_expected.to define_enum_for(:gender).with_values(%i[female male]) }
    it { is_expected.to define_enum_for(:situation).with_values(%i[found lost]) }
  end
end
