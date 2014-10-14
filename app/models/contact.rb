class Contact < ActiveRecord::Base
  attr_accessible :email, :encrypted_id, :name, :phone, :voted
  
  belongs_to :rounds
  has_many :votes
  
  require 'securerandom'
  
  # Sets the encrypted_id
  def set_encrypted_id
    self.encrypted_id = SecureRandom.hex
  end
end