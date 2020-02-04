# frozen_string_literal: true

module Api
  module V1
    class OmniauthUserSerializer < ActiveModel::Serializer
      attributes :id, :first_name, :last_name, :email, :phone_number,
                 :onboarding_finished, :picture_url, :provider, :uid,
                 :token, :created_at, :updated_at

      def onboarding_finished
        object.phone_number.present?
      end

      def token
        object.create_new_auth_token
      end
    end
  end
end
