class RemovabilityGround < ActiveRecord::Base
  has_many :convictions, through: :conviction_grounds
  has_many :conviction_grounds
  self.primary_key = 'name'
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
