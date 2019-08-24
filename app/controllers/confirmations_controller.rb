# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  def after_confirmation_path_for(resource_name, resource)
    sign_in(resource)
    home_path
  end
end
