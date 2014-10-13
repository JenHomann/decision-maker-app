class Vote < ActiveRecord::Base
  attr_accessible :contact_id, :option_id, :points
end
