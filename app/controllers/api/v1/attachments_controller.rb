# frozen_string_literal: true

module Api
  module V1
    class AttachmentsController < ApiController
      before_action :authenticate_user!, only: %i[destroy]
      before_action :fetch_attachment, only: %i[destroy]

      def destroy
        @attachment.purge

        head :no_content
      end

      private

      def fetch_attachment
        @attachment = ActiveStorage::Attachment.where(record: current_user.pets).find(params[:id])
      end
    end
  end
end
