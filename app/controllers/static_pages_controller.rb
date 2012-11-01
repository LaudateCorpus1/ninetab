class StaticPagesController < ApplicationController

  VALID_EMAIL_REGEX = /^[\w+\-.]+@[a-z\d\-.]+\.[a-z]+$/i

  def home
  end

  def description    
  end
  
  def specification
  end

  def contact  
    if request.request_method_symbol == :post
      if params[:email].blank?
        flash[:alert] = t(:ALERT_EMAIL_BLANK)
        return
      elsif params[:email] !~ VALID_EMAIL_REGEX
        flash[:alert] = t(:ALERT_EMAIL_FORMAT)
        return
      elsif params[:message].blank?
        flash[:alert] = t(:ALERT_MESSAGE_BLANK)
        return
      end

      begin
        ContactMailer.contact_email(params).deliver
        flash[:notice] = t(:MAIL_SUCCESS)
        redirect_to contact_path
      rescue
        flash[:alert] = t(:MAIL_ERROR)
      end
    end
  end
end
