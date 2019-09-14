# frozen_string_literal: true

module Api
  module V1
    module Me
      class PetsController < ApiController
        include Pets::Filterable

        def index
          render json: PetQuery.new(current_user.pets)
                               .filter(api_filter_params)
                               .sorted_by_creation_date(:desc)
        end
      end
    end
  end
end
