# frozen_string_literal: true

module Api
  module V1
    class PetSerializer < ActiveModel::Serializer
      include Rails.application.routes.url_helpers

      belongs_to :breed

      attributes :id, :name, :age, :gender, :description,
                 :situation, :address, :latitude, :longitude,
                 :deactivated_at, :created_at, :updated_at,
                 :pictures

      def pictures
        object.pictures.zip(thumbnails).collect do |(original, thumbnail)|
          {
            'original' => url_for(original),
            'thumbnail' => thumbnail ? url_for(thumbnail) : nil
          }
        end
      end

      private

      def thumbnails
        object.processed? ? object.thumbnails : []
      end
    end
  end
end
