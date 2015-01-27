class CreateClientReliefs < ActiveRecord::Migration
  def change
    create_table :client_reliefs do |t|
      t.string :relief_name
      t.integer :client_id

      t.timestamps
    end
  end
end
