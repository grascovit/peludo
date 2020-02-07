# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    module Pets
      RSpec.describe 'ContactLogs', type: :request do
        let(:user) { create(:user) }
        let(:pet) { create(:pet) }

        before do
          user.confirm
        end

        context 'with valid params' do
          it 'creates a new contact log' do
            expect do
              post api_v1_pet_contact_logs_path(pet), headers: user.create_new_auth_token
            end.to change(ContactLog, :count).by(1)
          end

          it 'returns created http status' do
            post api_v1_pet_contact_logs_path(pet), headers: user.create_new_auth_token

            expect(response).to have_http_status(:created)
          end
        end

        context 'with invalid params' do
          before do
            pet.update_column('user_id', nil)
          end

          it 'does not create a new contact log' do
            expect do
              post api_v1_pet_contact_logs_path(pet), headers: user.create_new_auth_token
            end.not_to change(ContactLog, :count)
          end

          it 'returns the error messages' do
            post api_v1_pet_contact_logs_path(pet), headers: user.create_new_auth_token

            expect(JSON.parse(response.body)).to match_array(
              [
                'Usuário requisitado é obrigatório(a)'
              ]
            )
          end

          it 'returns unprocessable entity http status' do
            post api_v1_pet_contact_logs_path(pet), headers: user.create_new_auth_token

            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end
    end
  end
end
