class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.string :name
      t.string :location
      t.string :price_range
      t.string :restaurant_type
      t.string :decision
      t.string :encrypted_url

      t.timestamps
    end
  end
end
