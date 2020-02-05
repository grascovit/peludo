# frozen_string_literal: true

module Api
  module V1
    class PetsController < ApiController
      include Pets::Filterable

      before_action :authenticate_user!, except: %i[index show]
      before_action :fetch_pet, only: %i[edit update destroy]

      def index
        render json: PetQuery.new
                             .filter(api_filter_params)
                             .sorted_by_creation_date(:desc)
      end

      def show
        render json: Pet.find(params[:id])
      end

      def create
        @pet = current_user.pets.new(pet_params)

        if @pet.save
          render json: @pet, status: :created
        else
          render json: @pet.errors.full_messages, status: :unprocessable_entity
        end
      end

      def update
        if @pet.update(pet_params)
          render json: @pet, status: :ok
        else
          render json: @pet.errors.full_messages, status: :unprocessable_entity
        end
      end

      def destroy
        @pet.deactivate!

        head :no_content
      end

      private

      def fetch_pet
        @pet = current_user.pets.find(params[:id])
      end

      def pet_params # rubocop:disable Metrics/MethodLength
        params.require(:pet).permit(
          :name,
          :age,
          :breed_id,
          :gender,
          :description,
          :address,
          :latitude,
          :longitude,
          :situation,
          pictures: []
        )
      end
    end
  end
end
