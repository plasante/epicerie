class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale_from_browser

  
  # il faut absolument fermer le browser pour killer la variable session[:initialized]
  # et reinitialiser I18n.locale
  
  def set_locale_from_browser
    if (session[:initialized].nil? || !session[:initialized])
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      I18n.locale = extract_locale_from_accept_language_header
      logger.debug "* Locale set to '#{I18n.locale}'"
    else
      logger.debug "* Locale already set to '#{I18n.locale}'"
    end
    session[:initialized] = true
  end
  
  private
  
  def extract_locale_from_accept_language_header
    if (!request.env['HTTP_ACCEPT_LANGUAGE'].nil?)
      # This test is necessary for the unit test
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    else
      # This the default locale
      'en'
    end
  end
end
