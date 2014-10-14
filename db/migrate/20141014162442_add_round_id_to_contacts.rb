class AddRoundIdToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :round_id, :integer
  end
end
