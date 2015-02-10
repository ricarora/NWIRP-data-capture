class AddColumnToConvictionForState < ActiveRecord::Migration
  def change
    add_column :convictions, :state_committed, :string
  end
end
