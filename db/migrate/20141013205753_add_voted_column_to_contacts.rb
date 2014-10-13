class AddVotedColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :voted, :boolean
  end
end
