class AddColumnDvOnRocToConvictionsTable < ActiveRecord::Migration
  def change
    add_column :convictions, :dv_on_roc, :boolean
  end
end
