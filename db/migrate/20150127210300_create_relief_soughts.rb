class CreateReliefSoughts < ActiveRecord::Migration
  def change
    create_table :relief_soughts do |t|
      t.string :name
      t.integer :client_id

      t.timestamps
    end
  end
end
