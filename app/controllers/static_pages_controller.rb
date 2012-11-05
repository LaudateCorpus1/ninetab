class StaticPagesController < ApplicationController

  before_filter :setup_negative_captcha, only: :contact

  VALID_EMAIL_REGEX = /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i

  def home
  end

  def description    
  end
  
  def specification
  end

  def contact  
    if request.request_method_symbol == :post
      if !@captcha.valid?      
        flash[:alert] = @captcha.error if @captcha.error 
        return
      end

      form_values = @captcha.values
      form_values[:locale] = params[:locale]
 
      if form_values[:email].blank?
        flash[:alert] = t(:ALERT_EMAIL_BLANK)
        return
      elsif form_values[:email] !~ VALID_EMAIL_REGEX
        flash[:alert] = t(:ALERT_EMAIL_FORMAT)
        return
      elsif form_values[:message].blank?
        flash[:alert] = t(:ALERT_MESSAGE_BLANK)
        return
      end

      begin
        ContactMailer.contact_email(form_values).deliver
        flash[:notice] = t(:MAIL_SUCCESS)
        redirect_to contact_path
      rescue
        flash[:alert] = t(:MAIL_ERROR)
      end
    end
  end

private
  def setup_negative_captcha
    @captcha = NegativeCaptcha.new(
      :secret => NEGATIVE_CAPTCHA_SECRET, #A secret key entered in environment.rb. 'rake secret' will give you a good one.
      :spinner => request.remote_ip, 
      :fields => [:subject, :email, :message], #Whatever fields are in your form 
      :params => params
    )
  end

end
