class CreateReliefSoughts < ActiveRecord::Migration
  def change
    create_table :relief_soughts, id: false do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :relief_soughts, :name, unique: true
  end
end
