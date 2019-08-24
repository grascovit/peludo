# frozen_string_literal: true

class ConfirmationsController < Devise::ConfirmationsController
  def after_confirmation_path_for(_, resource)
    sign_in(resource)
    home_path
  end
end
