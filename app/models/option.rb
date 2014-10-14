class Option < ActiveRecord::Base
  attr_accessible :image, :name, :round_id, :score, :url
  
  belongs_to :round
  has_many :votes
  
  def self.new_options
    self.create(name: "Option A")
    self.create(name: "Option B")
    self.create(name: "Option C")
  end
  
end
