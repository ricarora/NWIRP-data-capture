class ChangeIjFindingToTextType < ActiveRecord::Migration
  def change
    change_column :convictions, :ij_finding, :text
  end
end
