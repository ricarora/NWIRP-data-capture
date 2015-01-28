class ConvictionGround < ActiveRecord::Base
  has_many :grounds_for_removability, through: :conviction_ground
  validates :status, inclusion: { in: ["Yes", "No", "Finding Not Found"],
    message: "Only accepts Yes, No or Finding Not Found."}
  validates :gor_name, :uniqueness => { scope: [:conviction_id]}
  validates :conviction_id, numericality: { only_integer: true }
end
