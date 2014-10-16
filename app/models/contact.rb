class Contact < ActiveRecord::Base
  attr_accessible :email, :encrypted_id, :name, :phone, :voted, :round_id
  
  belongs_to :round
  
  require 'securerandom'
  
  # Sets the encrypted_id
  def set_encrypted_id
    self.encrypted_id = SecureRandom.hex
  end

end