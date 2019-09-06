# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'Registrations', type: :request do
      let!(:user) { create(:user) }
      let!(:lost_pet) { create(:pet, user: user, situation: :lost, deactivated_at: nil) }
      let!(:found_pet) { create(:pet, user: user, situation: :found, deactivated_at: nil) }

      before do
        user.confirm
      end

      describe 'DELETE #destroy' do
        context 'with valid headers' do
          subject(:deactivate_user) do
            delete api_v1_user_registration_path, headers: user.create_new_auth_token
          end

          it 'deactivates user and his/her registered pets' do
            deactivate_user
            user.reload
            lost_pet.reload
            found_pet.reload

            expect(user.deactivated_at).not_to be_nil
            expect(lost_pet.deactivated_at).not_to be_nil
            expect(found_pet.deactivated_at).not_to be_nil
          end

          it 'returns http success' do
            deactivate_user

            expect(response).to have_http_status(:ok)
          end

          it 'returns success message' do
            deactivate_user

            expect(JSON.parse(response.body)).to eq(
              'status' => 'success',
              'message' => "A conta com uid '#{user.uid}' foi excluída."
            )
          end
        end

        context 'with invalid headers' do
          subject(:deactivate_user) do
            delete api_v1_user_registration_path, headers: {}
          end

          it 'does not deactivates user and his/her registered pets' do
            deactivate_user
            user.reload
            lost_pet.reload
            found_pet.reload

            expect(user.deactivated_at).to be_nil
            expect(lost_pet.deactivated_at).to be_nil
            expect(found_pet.deactivated_at).to be_nil
          end

          it 'returns not found http status' do
            deactivate_user

            expect(response).to have_http_status(:not_found)
          end

          it 'returns error message' do
            deactivate_user

            expect(JSON.parse(response.body)).to eq(
              'status' => 'error',
              'success' => false,
              'errors' => [
                I18n.t('devise_token_auth.registrations.account_to_destroy_not_found')
              ]
            )
          end
        end
      end
    end
  end
end
