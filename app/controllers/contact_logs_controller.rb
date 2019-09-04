# frozen_string_literal: true

class ContactLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_contact_log, only: %i[show]

  def create
    @contact_log = ContactLog.create(contact_log_params)

    redirect_to contact_log_path(@contact_log), notice: t(".#{pet.situation}.success")
  end

  def show; end

  private

  def fetch_contact_log
    @contact_log = ContactLog.find(params[:id])
  end

  def pet
    @pet ||= Pet.find(params[:pet_id])
  end

  def contact_log_params
    {
      requesting_user: current_user,
      requested_user: pet.user,
      pet: pet
    }
  end
end
