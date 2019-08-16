# frozen_string_literal: true

class LostPetsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :fetch_pet, only: %i[edit update destroy]

  def index
    @pets = Pet.with_attached_pictures.where(situation: :lost).decorate
  end

  def show
    @pet = Pet.find(params[:id]).decorate
  end

  def new
    @pet = current_user.lost_pets.build
  end

  def create
    @pet = current_user.lost_pets.new(pet_params)
    @pet.situation = :lost

    if @pet.save
      redirect_to lost_pets_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @pet.update(pet_params)
      redirect_to lost_pets_path, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    @pet.destroy

    redirect_to lost_pets_path, notice: t('.success')
  end

  private

  def fetch_pet
    @pet = current_user.lost_pets.find(params[:id]).decorate
  end

  def pet_params
    params.require(:pet).permit(
      :name,
      :age,
      :breed_id,
      :gender,
      :description,
      :city,
      :state,
      :country,
      pictures: []
    )
  end
end
