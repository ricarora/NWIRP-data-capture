class RemoveReliefSoughtFromClients < ActiveRecord::Migration
  def change
    remove_column :clients, :relief_sought, :string
  end
end
