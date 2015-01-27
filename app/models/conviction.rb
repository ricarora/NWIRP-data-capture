class Conviction < ActiveRecord::Base
  validates :crime_name, :sentence, presence: true
  validates :sentence, numericality: { only_integer: true }
  validate :ij_decision_date_is_date?

  def ij_decision_date_is_date?
    if !ij_decision_date.respond_to?(:strftime)
      errors.add(:ij_decision_date, "Must be a valid date")
    end
  end
end
