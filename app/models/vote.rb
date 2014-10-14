class Vote < ActiveRecord::Base
  attr_accessible :contact_id, :option_id, :points
  
  belongs_to :option
  belongs_to :contact
  
end
