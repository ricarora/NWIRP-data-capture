class CreateConvictions < ActiveRecord::Migration
  def change
    create_table :convictions do |t|
      t.string :crime_name
      t.string :rcw
      t.string :subsection
      t.integer :sentence
      t.string :ij_name
      t.string :nta_charges
      t.datetime :ij_decision_date
      t.string :ij_finding
      t.integer :client_id
      t.text :notes

      t.timestamps
    end
  end
end
