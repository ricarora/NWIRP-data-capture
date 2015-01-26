class CreateGroundsForRemovabilities < ActiveRecord::Migration
  def change
    create_table :grounds_for_removabilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
