# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#flash_class' do
    subject { helper.flash_class(type) }

    context 'when flash type is alert' do
      let(:type) { 'alert' }

      it { is_expected.to eq('alert-danger') }
    end

    context 'when flash type is notice' do
      let(:type) { 'notice' }

      it { is_expected.to eq('alert-primary') }
    end
  end
end
