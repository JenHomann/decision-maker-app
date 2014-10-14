class ContactMailer < ActionMailer::Base
  default :from => ENV['USERNAME']
  
  def send_vote(contact)
    @contact = contact
    @round = @contact.round
    mail(:to => "#{contact.name} <#{contact.email}>", :subject => "Grupl: Cast your vote!")
  end
  
end
