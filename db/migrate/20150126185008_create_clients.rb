class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :last_name
      t.string :first_name
      t.string :nationality
      t.string :ethnicity
      t.string :gender
      t.string :relief_sought
      t.boolean :represented
      t.boolean :drru_case
      t.string :a_number

      t.timestamps
    end
  end
end
