class ChangeDateTimetoDateInConviction < ActiveRecord::Migration
  def change
    change_column :convictions, :ij_decision_date, :date
  end
end
