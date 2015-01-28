class RemovabilityGround < ActiveRecord::Base
  has_many :convictions, through: :conviction_ground
  self.primary_key = 'name'
  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
