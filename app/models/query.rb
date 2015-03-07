class Query < ActiveRecord::Base
  validates :name, presence: true
end
