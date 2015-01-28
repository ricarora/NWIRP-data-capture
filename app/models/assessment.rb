class Assessment < ActiveRecord::Base
  belongs_to :client
  validates :client_id, :date, presence: true
  validates :client_id, numericality: { only_integer: true }
  validate :is_a_date?, :date_cannot_be_in_the_future
  validates :date, :uniqueness => { scope: [:client_id]}

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
