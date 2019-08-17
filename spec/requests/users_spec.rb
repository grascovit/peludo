# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:valid_attributes) do
    {
      user: {
        first_name: 'First name',
        last_name: 'Last name',
        phone_number: '+55123456789',
        email: 'user@email.com',
        password: 'password'
      }
    }
  end
  let(:invalid_attributes) do
    {
      user: {
        first_name: '',
        last_name: '',
        phone_number: '',
        email: '',
        password: ''
      }
    }
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new user' do
        expect do
          post user_registration_path, params: valid_attributes
        end.to change(User, :count).by(1)
      end

      it 'redirects to the root page' do
        post user_registration_path, params: valid_attributes

        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new user' do
        expect do
          post user_registration_path, params: invalid_attributes
        end.not_to change(Pet, :count)
      end

      it 'renders the registration form again' do
        post user_registration_path, params: invalid_attributes

        expect(response).to have_http_status(:ok)
      end
    end
  end
end
