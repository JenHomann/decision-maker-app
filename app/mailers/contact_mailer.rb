class ContactMailer < ActionMailer::Base
  default :from => ENV['EMAIL']
  
  def send_vote(contact)
    #TODO - Test to ensure that round attributes are being passed into mailer send_vote view
    @round = round
    @contact = contact
    mail(:to => "#{contact.name} <#{contact.email}>", subject: => "Grupl: Cast your vote!")
  end
  
end
