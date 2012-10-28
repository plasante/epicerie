class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale_from_browser

  
  # Il faut absolument fermer le browser pour killer la variable session[:initialized]
  # et reinitialiser I18n.locale
  # http://localhost:3000/static_pages/home?locale=en-us
  # devrait changer la locale a 'en-us'
  
  def set_locale_from_browser
    if (session[:initialized].nil? || !session[:initialized])
      logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
      I18n.locale = extract_locale_from_accept_language_header
      logger.debug "* Locale set to '#{I18n.locale}'"
    elsif (!params[:locale].nil?)
      I18n.locale = params[:locale]
    else
      logger.debug "* Locale already set to '#{I18n.locale}'"
    end
    session[:initialized] = true
  end
  
  private
  
  def extract_locale_from_accept_language_header
    # Ce test est necessaire pour les test unitaires car request.env['HTTP_ACCEPT_LANGUAGE'] est nil
    if (!request.env['HTTP_ACCEPT_LANGUAGE'].nil?)
      request.env['HTTP_ACCEPT_LANGUAGE'].split(',').first
    else
      # Valeur par defaut
      'en'
    end
  end
end
