class ConvictionGround < ActiveRecord::Base
  has_many :grounds_for_removability, through: :conviction_ground
end
