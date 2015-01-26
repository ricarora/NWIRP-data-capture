class CreateConvictionGrounds < ActiveRecord::Migration
  def change
    create_table :conviction_grounds do |t|
      t.string :gor_name
      t.integer :conviction_id
      t.string :status

      t.timestamps
    end
  end
end
