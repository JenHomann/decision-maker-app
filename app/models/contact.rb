class Contact < ActiveRecord::Base
  attr_accessible :email, :encrypted_id, :name, :phone, :voted?
  
  require 'securerandom'
  
  def set_uid
    self.uid = SecureRandom.hex
  end
end