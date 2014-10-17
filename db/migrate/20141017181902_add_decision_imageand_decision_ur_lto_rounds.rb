class AddDecisionImageandDecisionUrLtoRounds < ActiveRecord::Migration
  def change
    add_column :rounds, :decision_image, :string
    add_column :rounds, :decision_url, :string
  end
  
end
