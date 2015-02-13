class AddRcwToConvictionsTable < ActiveRecord::Migration
  def change
    add_column :convictions, :rcw, :string
  end
end
