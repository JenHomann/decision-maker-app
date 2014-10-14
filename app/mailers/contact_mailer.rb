class ContactMailer < ActionMailer::Base
  default :from => ENV['EMAIL']
  
  def send_vote(contact)
    @round = contact.round
    @contact = contact
    mail(:to => "#{contact.name} <#{contact.email}>", :subject => "Grupl: Cast your vote!")
  end
  
end
