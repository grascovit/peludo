# frozen_string_literal: true

class ContactLogsController < ApplicationController
  before_action :fetch_pet, only: %i[create]

  def create
    @contact_log = ContactLog.create(
      requesting_user: current_user,
      requested_user: @pet.user,
      pet: @pet
    )

    redirect_to contact_log_path(@contact_log), notice: t('.success')
  end

  def show
    @contact_log = ContactLog.find(params[:id])
  end

  private

  def fetch_pet
    @pet = Pet.find(params[:pet_id])
  end
end
