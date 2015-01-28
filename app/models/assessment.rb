class Assessment < ActiveRecord::Base
  validates :client_id, :date, presence: true
  validate :is_a_date?

  def is_a_date?
    if !date.respond_to?(:strftime)
      errors.add(:date, "must be a valid date")
    end
  end
end
