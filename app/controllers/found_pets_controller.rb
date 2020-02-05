# frozen_string_literal: true

class FoundPetsController < ApplicationController
  include Pets::Filterable

  before_action :authenticate_user!, except: %i[index show]
  before_action :fetch_pet, only: %i[edit update destroy]

  def index
    @pets = PetQuery.new
                    .filter(web_filter_params(situation: :found))
                    .sorted_by_creation_date(:desc)
                    .decorate
  end

  def show
    @pet = Pet.find(params[:id]).decorate
  end

  def new
    @pet = current_user.pets.build
  end

  def create
    @pet = current_user.pets.new(pet_params)
    @pet.situation = :found

    if @pet.save
      redirect_to found_pets_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @pet.update(pet_params)
      redirect_to found_pets_path, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    Draper.undecorate(@pet).deactivate!

    redirect_to found_pets_path, notice: t('.success')
  end

  private

  def fetch_pet
    @pet = current_user.pets.find(params[:id]).decorate
  end

  def pet_params
    params.require(:pet).permit(
      :name,
      :breed_id,
      :gender,
      :description,
      :address,
      :latitude,
      :longitude,
      pictures: []
    )
  end
end
