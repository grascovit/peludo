# frozen_string_literal: true

module Api
  module V1
    module Pets
      class ContactLogsController < ApiController
        before_action :authenticate_user!
        before_action :fetch_pet

        def create
          @contact_log = ContactLog.create(contact_log_params)

          if @contact_log.save
            head :created
          else
            render json: @contact_log.errors.full_messages, status: :unprocessable_entity
          end
        end

        private

        def fetch_pet
          @pet = Pet.find(params[:pet_id])
        end

        def contact_log_params
          {
            requesting_user: current_user,
            requested_user: @pet.user,
            pet: @pet
          }
        end
      end
    end
  end
end
