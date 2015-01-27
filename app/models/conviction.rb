class Conviction < ActiveRecord::Base
  validates :crime_name, :sentence, presence: true
  validates :sentence, numericality: { only_integer: true }
end
