class ChangeRcWtoStatuteOfConviction < ActiveRecord::Migration
  def change
    rename_column :convictions, :rcw, :statute_of_conviction
  end
end
