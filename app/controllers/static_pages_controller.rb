class StaticPagesController < ApplicationController
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
      elsif params[:message].blank?
        flash[:alert] = t(:ALERT_MESSAGE_BLANK)
        return
      end

      begin
        ContactMailer.contact_email(params).deliver
        flash[:notice] = t(:MAIL_SUCCESS)
        redirect_to contact_path
      rescue
        flash[:alert] = t(:MAIL_ERORR)
      end
    end
  end
end
