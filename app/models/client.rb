class Client < ActiveRecord::Base
  has_many :assessments
  has_many :convictions
  has_many :relief_soughts, through: :client_relief
  validates :first_name, :last_name, :gender, :represented, :a_number,
            :nationality, presence: true
  validates_uniqueness_of :a_number
  validates :gender, inclusion: { in: %w(Male Female),
    message: "Only accepts Male or Female."}
end
