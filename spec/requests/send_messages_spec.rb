require 'spec_helper'

describe "SendMessages" do

  before(:each) { ActionMailer::Base.deliveries = [] }
  let(:last_email) { ActionMailer::Base.deliveries.last }

  it 'sends email with message' do
    visit root_path
    click_link I18n.t(:NAV_CONTACT)
    fill_in I18n.t(:FORM_EMAIL), with: 'test@example.com'
    fill_in I18n.t(:FORM_SUBJECT), with: 'Dotaz'
    fill_in I18n.t(:FORM_MESSAGE), with: 'Obsah zpravy'
    click_button I18n.t(:SEND_MESSAGE_BUTTON)
    page.should have_content I18n.t(:MAIL_SUCCESS)
    last_email.from.should == ['test@example.com']
    last_email.body.encoded.should match('Dotaz')
    last_email.body.encoded.should match('Obsah zpravy')
  end

end