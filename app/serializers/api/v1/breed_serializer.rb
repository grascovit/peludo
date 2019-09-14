# frozen_string_literal: true

module Api
  module V1
    class BreedSerializer < ActiveModel::Serializer
      attributes :id, :name, :created_at, :updated_at
    end
  end
end
