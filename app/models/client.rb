class Client < ActiveRecord::Base
  validates :first_name, :last_name, :gender, presence: true
  validates :gender, inclusion: { in: %w(Male Female),
    message: "Only accepts Male or Female."}
end
