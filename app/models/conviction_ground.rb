class ConvictionGround < ActiveRecord::Base
  belongs_to :conviction
  belongs_to :removability_ground
  validates :status, inclusion: { in: ["Yes", "No", "Finding Not Found"],
    message: "Only accepts Yes, No or Finding Not Found."}
  validates :gor_name, :uniqueness => { scope: [:conviction_id]}
  validates :conviction_id, numericality: { only_integer: true }
end
