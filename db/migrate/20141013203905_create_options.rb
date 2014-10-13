class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :name
      t.string :image
      t.integer :score
      t.integer :round_id
      t.string :url

      t.timestamps
    end
  end
end
