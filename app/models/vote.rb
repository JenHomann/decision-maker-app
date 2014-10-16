class Vote < ActiveRecord::Base
  attr_accessible :contact_id, :option_id, :points, :response
  
  belongs_to :option
  belongs_to :contact
  
  # Assigns an integer to points based on the user's response to each vote
  # 
  # Returns the Vote object, with a points attribute saved
  def assign_points
    if response == "yes"
      points = 1
    elsif response == "no"
      points = 0
    end
    self.save
  end
  
  # 
  # 
  # 
  def self.tally_score(option_id)
    votes_array = Vote.where(option_id: 1)
    score = 0
    votes_array.each do |vote|
      score += vote.points
    end
    return score
  end
  
end