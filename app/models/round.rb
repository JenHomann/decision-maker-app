class Round < ActiveRecord::Base
  attr_accessible :decision, :encrypted_url, :location, :name, :price_range, :restaurant_type
  
  require 'securerandom'
  
  has_many :contacts
  has_many :options
  
  accepts_nested_attributes_for :contacts, :allow_destroy => true, :reject_if :email_is_blank
  
  # Evaluates whether an email has been submitted
  def email_is_blank
    if attrs['email'].blank?
      true
    else
      false
    end
  end
  
  # Sets the encrypted_url
  def set_encrypted_url
    self.encrypted_url = SecureRandom.hex
  end
  
end