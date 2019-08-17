# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ContactLog, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:requesting_user).class_name('User') }
    it { is_expected.to belong_to(:requested_user).class_name('User') }
    it { is_expected.to belong_to(:pet) }
  end
end
