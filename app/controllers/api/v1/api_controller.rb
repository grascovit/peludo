# frozen_string_literal: true

module Api
  module V1
    class ApiController < ActionController::API
      include DeviseTokenAuth::Concerns::SetUserByToken

      before_action do
        self.namespace_for_serializer = Api::V1
      end

      def current_user
        @resource if super && @resource.deactivated_at.nil?
      end
    end
  end
end
