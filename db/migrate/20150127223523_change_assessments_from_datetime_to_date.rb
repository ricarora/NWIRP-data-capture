class ChangeAssessmentsFromDatetimeToDate < ActiveRecord::Migration
  def change
    change_column :assessments, :date, :date
  end
end
