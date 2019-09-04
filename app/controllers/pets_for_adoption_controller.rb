# frozen_string_literal: true

class PetsForAdoptionController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :fetch_pet, only: %i[edit update destroy]

  PAGE_SIZE = 9

  def index
    @pets = PetQuery.new.filter(filter_params)
                    .sorted_by_creation_date(:desc)
                    .decorate
  end

  def show
    @pet = Pet.find(params[:id]).decorate
  end

  def new
    @pet = current_user.pets_for_adoption.build
  end

  def create
    @pet = current_user.pets_for_adoption.new(pet_params)
    @pet.situation = :for_adoption

    if @pet.save
      redirect_to pets_for_adoption_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @pet.update(pet_params)
      redirect_to pets_for_adoption_path, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy

    redirect_to pets_for_adoption_path, notice: t('.success')
  end

  private

  def fetch_pet
    @pet = current_user.pets_for_adoption.find(params[:id]).decorate
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
      pictures: []
    )
  end

  def filter_params
    {
      situation: :for_adoption,
      page: params[:page] || 1,
      per_page: PAGE_SIZE,
      breed_id: params[:breed_id],
      gender: params[:gender],
      address: params[:address]
    }
  end
end
