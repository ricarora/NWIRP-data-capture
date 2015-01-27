class Client < ActiveRecord::Base
  validates :first_name, :last_name, :gender, :represented, :a_number, presence: true
  validates_uniqueness_of :a_number
  validates :gender, inclusion: { in: %w(Male Female),
    message: "Only accepts Male or Female."}
end
