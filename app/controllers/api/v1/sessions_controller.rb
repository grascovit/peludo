# frozen_string_literal: true

module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      def create
        super
        @resource.reactivate! if @token.present?
      end
    end
  end
end
