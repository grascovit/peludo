# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'Pets', type: :request do
      let(:user) { create(:user) }
      let(:breed) { create(:breed) }
      let!(:pet) { create(:pet, user: user) }
      let(:valid_attributes) do
        {
          pet: {
            name: 'Rex',
            breed_id: breed.id,
            gender: 'male',
            address: 'Address',
            latitude: '-12.123',
            longitude: '49.123',
            situation: 'lost',
            pictures: [
              Rack::Test::UploadedFile.new('spec/fixtures/files/placeholder.png', 'image/png'),
              Rack::Test::UploadedFile.new('spec/fixtures/files/placeholder.png', 'image/png')
            ]
          }
        }
      end
      let(:invalid_attributes) do
        {
          pet: {
            name: '',
            breed_id: '',
            gender: '',
            address: '',
            latitude: '',
            longitude: '',
            situation: ''
          }
        }
      end

      before do
        user.confirm
      end

      describe 'GET #index' do
        it 'returns http success' do
          get api_v1_pets_path

          expect(response).to have_http_status(:ok)
        end

        it 'returns the pets list' do
          get api_v1_pets_path

          expect(response).to match_json_schema('v1/pets')
        end
      end

      describe 'GET #show' do
        it 'returns http success' do
          get api_v1_pet_path(pet)

          expect(response).to have_http_status(:ok)
        end

        it 'returns the pet' do
          get api_v1_pet_path(pet)

          expect(response).to match_json_schema('v1/pet')
        end
      end

      describe 'POST #create' do
        context 'with valid params' do
          it 'creates a new pet' do
            expect do
              post api_v1_pets_path, params: valid_attributes, headers: user.create_new_auth_token
            end.to change(Pet, :count).by(1)
          end

          it 'returns the created pet' do
            post api_v1_pets_path, params: valid_attributes, headers: user.create_new_auth_token

            expect(response).to match_json_schema('v1/pet')
          end

          it 'returns created http status' do
            post api_v1_pets_path, params: valid_attributes, headers: user.create_new_auth_token

            expect(response).to have_http_status(:created)
          end
        end

        context 'with invalid params' do
          it 'does not create a new pet' do
            expect do
              post api_v1_pets_path, params: invalid_attributes, headers: user.create_new_auth_token
            end.not_to change(Pet, :count)
          end

          it 'returns the error messages' do
            post api_v1_pets_path, params: invalid_attributes, headers: user.create_new_auth_token

            expect(JSON.parse(response.body)).to match_array(
              [
                'Situação não pode ficar em branco',
                'Endereço não pode ficar em branco',
                'Fotos são obrigatórias',
                'Selecione um local ou endereço sugerido'
              ]
            )
          end

          it 'returns unprocessable entity http status' do
            post api_v1_pets_path, params: invalid_attributes, headers: user.create_new_auth_token

            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe 'PATCH/PUT #update' do
        context 'with valid params' do
          let(:new_attributes) do
            {
              pet: {
                name: 'New name'
              }
            }
          end

          it 'updates the requested pet' do
            expect do
              put api_v1_pet_path(pet), params: new_attributes, headers: user.create_new_auth_token
              pet.reload
            end.to change(pet, :name).from(pet.name).to('New name')
          end

          it 'returns the updated pet' do
            put api_v1_pet_path(pet), params: new_attributes, headers: user.create_new_auth_token
            pet.reload

            expect(response).to match_json_schema('v1/pet')
          end

          it 'returns ok http status' do
            put api_v1_pet_path(pet), params: new_attributes, headers: user.create_new_auth_token

            expect(response).to have_http_status(:ok)
          end
        end

        context 'with invalid params' do
          it 'does not update the pet' do
            old_name = pet.name
            put api_v1_pet_path(pet), params: invalid_attributes, headers: user.create_new_auth_token
            pet.reload

            expect(pet.name).to eq(old_name)
          end

          it 'returns unprocessable entity http status' do
            put api_v1_pet_path(pet), params: invalid_attributes, headers: user.create_new_auth_token

            expect(response).to have_http_status(:unprocessable_entity)
          end
        end
      end

      describe 'DELETE #destroy' do
        it 'destroys the requested pet registry' do
          expect do
            delete api_v1_pet_path(pet), headers: user.create_new_auth_token
          end.to change(Pet, :count).by(-1)
        end

        it 'returns no content http status' do
          delete api_v1_pet_path(pet), headers: user.create_new_auth_token

          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
