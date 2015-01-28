class ConvictionGround < ActiveRecord::Base
  has_many :grounds_for_removability, through: :conviction_ground
  validates :status, inclusion: { in: %w(Yes No),
    message: "Only accepts Yes, No or Finding not found."}
  validates :gor_name, :uniqueness => { scope: [:conviction_id]}
end
