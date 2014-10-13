class Contact < ActiveRecord::Base
  attr_accessible :email, :encrypted_id, :name, :phone, :voted?
end
