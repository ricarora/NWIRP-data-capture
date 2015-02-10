class ChangeRepresentedFromBooleanToString < ActiveRecord::Migration
  def change
    change_column :clients, :represented, :string
  end
end
