class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.boolean :voted?
      t.string :encrypted_id

      t.timestamps
    end
  end
end
