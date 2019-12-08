# frozen_string_literal: true

module Api
  module V1
    class OmniauthController < ApiController
      GOOGLE_OAUTH2_PROVIDER = 'google_oauth2'

      before_action :validate_id_token, only: :google_oauth2

      def google_oauth2
        @user = User.from_omniauth(omniauth_params)

        if @user.persisted?
          render json: @user, status: :ok, serializer: OmniauthUserSerializer
        else
          render json: @user.errors.full_messages, status: :unprocessable_entity
        end
      end

      private

      def omniauth_params
        @omniauth_params ||= OmniAuth::AuthHash.new(
          uid: id_token['sub'],
          provider: GOOGLE_OAUTH2_PROVIDER,
          info: {
            email: id_token['email'],
            first_name: id_token['given_name'],
            last_name: id_token['family_name']
          }
        )
      end

      def id_token
        @id_token ||= JWT.decode(params['id_token'], nil, false).first
      end

      def validate_id_token
        id_token
      rescue JWT::DecodeError
        head :bad_request
      end
    end
  end
end
