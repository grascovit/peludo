# frozen_string_literal: true

require 'rails_helper'

module Pets
  RSpec.describe 'ContactLogs', type: :request do
    let(:requesting_user) { create(:user) }
    let(:requested_user) { create(:user) }
    let(:pet) { create(:pet, user: requested_user) }
    let!(:contact_log) do
      create(:contact_log,
             requesting_user: requesting_user,
             requested_user: requested_user,
             pet: pet)
    end

    before do
      requesting_user.confirm
      sign_in(requesting_user)
    end

    describe 'POST #create' do
      context 'with valid params' do
        it 'creates a new log' do
          expect do
            post pet_contact_logs_path(pet)
          end.to change(ContactLog, :count).by(1)
        end

        it 'redirects to the log page' do
          post pet_contact_logs_path(pet)

          expect(response).to redirect_to(pet_contact_log_path(pet, ContactLog.last))
        end
      end

      context 'with invalid params' do
        it 'does not create a new log' do
          expect do
            post pet_contact_logs_path(nil)
          end.to raise_error(ActionController::UrlGenerationError)
        end
      end
    end

    describe 'GET #show' do
      it 'returns http success' do
        get pet_contact_log_path(pet, contact_log)

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
