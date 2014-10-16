class AddResponsetoVotes < ActiveRecord::Migration
  def change
    add_column :votes, :response, :string
  end
end
