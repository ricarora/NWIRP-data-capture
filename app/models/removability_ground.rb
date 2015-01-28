class RemovabilityGround < ActiveRecord::Base
  self.primary_key = 'name'
  validates :name, presence: true, uniqueness: { case_sensitive: false }

end
