class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale_from_browser

  
  # Il faut absolument fermer le browser pour killer la variable session[:initialized]
  # et reinitialiser I18n.locale
  # http://localhost:3000/static_pages/home?locale=en-us
  # devrait changer la locale a 'en-us'
  
  def set_locale_from_browser
    logger.debug "*** Setting locale"
    if (session[:locale].nil?)
      parsed_locale = extract_locale_from_accept_language_header
      if ( I18n.available_locales.include?( parsed_locale.to_sym ) )
        logger.debug("*** Accept-Language #{request.env['HTTP_ACCEPT_LANGUAGE']} was found")
        session[:locale] = parsed_locale
      else
        logger.debug("*** Accept-Language #{request.env['HTTP_ACCEPT_LANGUAGE']} was not found")
        session[:locale] = 'en'
      end
    elsif (!params[:locale].nil?)
      if ( I18n.available_locales.include?( params[:locale].to_sym ) )
        logger.debug("*** params[:locale] = " + params[:locale] + " is supported")
        session[:locale] = params[:locale]
      else
        logger.debug("*** params[:locale] = " + params[:locale] + " is not supported")
        session[:locale] = 'en'
      end
    end
    I18n.locale = session[:locale]
    logger.debug "*** Locale = #{I18n.locale}"
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
