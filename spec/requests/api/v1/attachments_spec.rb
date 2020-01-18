# frozen_string_literal: true

require 'rails_helper'

module Api
  module V1
    RSpec.describe 'Attachments', type: :request do
      let(:user) { create(:user) }
      let!(:attachment) { create(:pet, user: user).pictures.first }

      describe 'DELETE #destroy' do
        it 'destroys the requested attachment' do
          expect do
            delete api_v1_attachment_path(attachment), headers: user.create_new_auth_token
          end.to change(ActiveStorage::Attachment, :count).by(-1)
        end

        it 'returns no content http status' do
          delete api_v1_attachment_path(attachment), headers: user.create_new_auth_token

          expect(response).to have_http_status(:no_content)
        end
      end
    end
  end
end
