# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'Breeds', type: :request do
      before do
        create(:breed)
      end

      describe 'GET #index' do
        it 'returns http success' do
          get api_v1_breeds_path

          expect(response).to have_http_status(:ok)
        end

        it 'returns the pets list' do
          get api_v1_breeds_path

          expect(response).to match_json_schema('v1/breeds')
        end
      end
    end
  end
end
