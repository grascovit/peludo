# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone_number])
  end

  def set_locale(&action)
    locale = extract_locale_from_header || I18n.default_locale
    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_header
    accept_language_header = request.headers['Accept-Language'] || ''
    user_locales = accept_language_header.scan(/[a-z]{2}-[A-Z]{2}/)
    server_locales = I18n.available_locales.map(&:to_s)
    
    (user_locales & server_locales).first
  end
end
