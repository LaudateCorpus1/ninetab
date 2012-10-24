class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale
   
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    if I18n.locale == I18n.default_locale
      { locale: '' }
    else
      { locale: I18n.locale }
    end
  end

end
