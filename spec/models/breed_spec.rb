# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breed, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).case_insensitive }
  end

  describe 'scopes' do
    describe '.sorted_by_name' do
      subject(:sorted_breeds) { described_class.sorted_by_name(order) }

      let!(:pug) { create(:breed, name: 'Pug') }
      let!(:beagle) { create(:breed, name: 'Beagle') }
      let!(:dachshund) { create(:breed, name: 'Dachshund') }

      context 'when sorting by ascending order' do
        let(:order) { :asc }

        it 'returns the breeds in ascending order' do
          expect(sorted_breeds).to eq([beagle, dachshund, pug])
        end
      end

      context 'when sorting by descending order' do
        let(:order) { :desc }

        it 'returns the breeds in descending order' do
          expect(sorted_breeds).to eq([pug, dachshund, beagle])
        end
      end
    end
  end
end
