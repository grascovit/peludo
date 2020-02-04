# frozen_string_literal: true

module Api
  module V1
    class BreedsController < ApiController
      def index
        render json: Breed.sorted_by_name(:asc)
      end
    end
  end
end
