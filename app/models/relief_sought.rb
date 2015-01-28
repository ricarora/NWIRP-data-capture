class ReliefSought < ActiveRecord::Base
  self.primary_key = 'name'
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
