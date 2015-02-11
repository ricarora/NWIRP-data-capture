class EthnicityColumnToArrayType < ActiveRecord::Migration
  def change
    change_column :clients, :ethnicity, "varchar[] USING (string_to_array(ethnicity, ','))"
  end
end
