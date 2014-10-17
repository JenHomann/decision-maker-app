class ContactMailer < ActionMailer::Base
  default :from => ENV['USERNAME']
  
  def send_vote(contact)
    @contact = contact
    @round = @contact.round
    mail(:to => "#{contact.name} <#{contact.email}>", :subject => "Grupl: Cast your vote!")
  end
  
  def decision(contact, decision)
    @contact = contact
    @round = @contact.round
    @decision = decision
    mail(:to => "#{contact.name} <#{contact.email}>", :subject => "Grupl: A decision has been made!")
  end
  
  def confirm(initial_contact)
    @initial_contact = initial_contact
    @round = @initial_contact.round
    mail(:to => "#{initial_contact.name} <#{initial_contact.email}>", :subject => "Grupl: Your round has been created!")
  end
  
end
