# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    module Me
      RSpec.describe 'Pets', type: :request do
        let(:user) { create(:user) }

        before do
          user.confirm
          create(:pet, user: user)
        end

        describe 'GET #index' do
          it 'returns http success' do
            get api_v1_me_pets_path, headers: user.create_new_auth_token

            expect(response).to have_http_status(:ok)
          end

          it 'returns the pets list' do
            get api_v1_me_pets_path, headers: user.create_new_auth_token

            expect(response).to match_json_schema('v1/pets')
          end
        end
      end
    end
  end
end
