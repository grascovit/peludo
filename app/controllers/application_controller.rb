# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  around_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name phone_number])
  end

  def set_locale(&action)
    I18n.locale = extract_locale_from_header || I18n.default_locale
    logger.debug "* Locale set to '#{I18n.locale}'"
    I18n.with_locale(locale, &action)
  end

  def extract_locale_from_header
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    accept_language_header = request.headers['Accept-Language']
    locale = accept_language_header.scan(/^[a-z]{2}/).first
    I18n.available_locales.map(&:to_s).include?(locale) ? locale : nil
  end
end
