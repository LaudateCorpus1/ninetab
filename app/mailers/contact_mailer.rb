class ContactMailer < ActionMailer::Base
  default to: 'info@ninetab.com'

  def contact_email(params)
    @email   = params[:email] || headers[:to]
    @subject = params[:subject]
    @message = params[:message]
    @locale  = params[:locale]
    mail from: @email, subject: t(:MAIL_SUBJECT)
  end
end