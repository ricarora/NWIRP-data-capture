class Assessment < ActiveRecord::Base
  belongs_to :client
  validates :date, presence: true
  validate :is_a_date?, :date_cannot_be_in_the_future
  validates :date, :uniqueness => { scope: [:client_id]}

  def is_a_date?
    if date.present? && !date.respond_to?(:strftime)
      errors.add(:date, "must be a valid date")
    end
  end

  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
  end
end
