class Assessment < ActiveRecord::Base
  validates :client_id, :date, presence: true
  validate :is_a_date?, :date_cannot_be_in_the_future

  def is_a_date?
    if !date.respond_to?(:strftime)
      errors.add(:date, "must be a valid date")
    end
  end

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
