# encoding: utf-8

require 'spec_helper'
 
describe ContactMailer do
  describe 'contact email' do
    let(:recipient) { 'info@ninetab.com' }
    let(:params) do 
      { 
        email: 'test@example.com',
        subject: 'Testovací předmět zprávy',
        message: 'Testovací message',
        locale: 'cs'
      }
    end
    let(:mail) { ContactMailer.contact_email(params) }
 
    it 'renders the subject' do
      mail.subject.should == 'Zpráva z webu ninetab.com'
    end
 
    it 'renders the receiver email' do
      mail.to.should == [recipient]
    end
 
    it 'renders the sender email' do
      mail.from.should == ['test@example.com']
    end
     
    it 'assigns Jazyk' do
      mail.body.encoded.should match('Jazyk:   cs')
    end

    it 'assigns Předmět' do
      mail.body.encoded.should match('Předmět: ' << params[:subject])
    end
 
    it 'assigns Zpráva' do
      mail.body.encoded.should match('Zpráva:  ' << params[:message])
    end

    it 'assigns Email' do
      mail.body.encoded.should match('Email:   ' << params[:email])
    end
  end
end