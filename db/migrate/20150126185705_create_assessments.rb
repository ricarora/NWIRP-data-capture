class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.datetime :date
      t.integer :client_id

      t.timestamps
    end
  end
end
