class AddColumnsForANumberEncryption < ActiveRecord::Migration
  def change
    add_column :clients, :encrypted_a_number, :string
    add_column :clients, :encrypted_a_number_salt, :string
    add_column :clients, :encrypted_a_number_iv, :string
  end
end
