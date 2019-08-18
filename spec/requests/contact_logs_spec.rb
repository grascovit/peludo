# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'FoundPets', type: :request do
  let(:requesting_user) { create(:user) }
  let(:requested_user) { create(:user) }
  let(:pet) { create(:pet, user: requested_user) }
  let!(:contact_log) do
    create(:contact_log,
           requesting_user: requesting_user,
           requested_user: requested_user,
           pet: pet)
  end
  let(:valid_attributes) do
    {
      pet_id: pet.id
    }
  end
  let(:invalid_attributes) do
    {
      pet_id: nil
    }
  end

  before do
    requesting_user.confirm
    sign_in(requesting_user)
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new log' do
        expect do
          post contact_logs_path, params: valid_attributes
        end.to change(ContactLog, :count).by(1)
      end

      it 'redirects to the log page' do
        post contact_logs_path, params: valid_attributes

        expect(response).to redirect_to(contact_log_path(ContactLog.last))
      end
    end

    context 'with invalid params' do
      it 'does not create a new log' do
        expect do
          post contact_logs_path, params: invalid_attributes
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get contact_log_path(contact_log)

      expect(response).to have_http_status(:ok)
    end
  end
end
