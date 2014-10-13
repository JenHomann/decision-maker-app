class RemoveVotedFromContacts < ActiveRecord::Migration
  def change
    remove_column :contacts, :voted?
  end

end
