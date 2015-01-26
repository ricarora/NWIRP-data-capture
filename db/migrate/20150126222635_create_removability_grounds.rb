class CreateRemovabilityGrounds < ActiveRecord::Migration
  def change
    create_table :removability_grounds, id: false do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :removability_grounds, :name, unique: true
  end
end
