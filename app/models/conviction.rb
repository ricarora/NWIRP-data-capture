class Conviction < ActiveRecord::Base
  validates :crime_name, presence: true
end
