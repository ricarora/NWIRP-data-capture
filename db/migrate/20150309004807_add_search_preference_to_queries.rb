class AddSearchPreferenceToQueries < ActiveRecord::Migration
  def change
    add_column :queries, :search_preference, :string
  end
end
