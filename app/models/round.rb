class Round < ActiveRecord::Base
  attr_accessible :decision, :encrypted_url, :location, :name, :price_range, :restaurant_type
  
  has_many :contacts
  has_many :options
  
end
