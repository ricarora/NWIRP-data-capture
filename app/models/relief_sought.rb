class ReliefSought < ActiveRecord::Base
  has_many :clients, through: :client_relief
  self.primary_key = 'name'
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
