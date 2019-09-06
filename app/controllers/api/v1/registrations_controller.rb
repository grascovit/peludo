# frozen_string_literal: true

module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      def destroy
        if @resource
          @resource.deactivate!
          yield @resource if block_given?
          render_destroy_success
        else
          render_destroy_error
        end
      end
    end
  end
end
