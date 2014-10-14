class Round < ActiveRecord::Base
  attr_accessible :decision, :encrypted_url, :location, :name, :price_range, :restaurant_type
  
  require 'securerandom'
  
  has_many :contacts
  has_many :options
  
  # Sets the encrypted_url
  def set_encrypted_url
    self.encrypted_url = SecureRandom.hex
  end
  
end
