class AddSentenceTypeToConviction < ActiveRecord::Migration
  def change
    add_column :convictions, :sentence_type, :string
  end
end
