class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def set_locale
    if params[:locale].blank?
      if extract_locale_from_accept_language_header == :cs
        redirect_to '/cs'
      else
        redirect_to '/en'
      end
    end

    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    # if I18n.locale == I18n.default_locale
    #   { locale: '' }
    # else
      { locale: I18n.locale }
    # end
  end

  # extract the language from the clients browser
  def extract_locale_from_accept_language_header
    browser_locale = request.env['HTTP_ACCEPT_LANGUAGE'].try(:scan, /^[a-z]{2}/).try(:first).try(:to_sym)
    if I18n.available_locales.include? browser_locale
      browser_locale
    else
      I18n.default_locale
    end
  end

end
