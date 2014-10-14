class Option < ActiveRecord::Base
  attr_accessible :image, :name, :round_id, :score, :url
  
  belongs_to :round
  has_many :votes
  
end
