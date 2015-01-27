class Conviction < ActiveRecord::Base
  validates :crime_name, :sentence, presence: true
  validates :sentence, numericality: { only_integer: true }
  validate :ij_decision_date_is_date?
  validate :ij_decision_date_cannot_be_in_the_future

  def ij_decision_date_is_date?
    if !ij_decision_date.respond_to?(:strftime)
      errors.add(:ij_decision_date, "must be a valid date")
    end
  end

  def ij_decision_date_cannot_be_in_the_future
    if ij_decision_date.present? && ij_decision_date > Date.today
      errors.add(:ij_decision_date, "can't be in the future")
    end
  end
end
