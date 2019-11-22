# frozen_string_literal: true

class RegistrationsController < Devise::RegistrationsController
  EMAIL_PROVIDER = 'email'

  def destroy
    resource.deactivate!
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource) { redirect_to after_sign_out_path_for(resource_name) }
  end

  protected

  def update_resource(resource, params)
    return super if resource.provider == EMAIL_PROVIDER

    resource.update_without_password(params)
  end
end
