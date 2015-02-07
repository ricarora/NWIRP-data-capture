class Conviction < ActiveRecord::Base
  require 'SecureRandom'
  belongs_to :client
  has_many :removability_grounds, through: :conviction_grounds
  has_many :conviction_grounds, autosave: true
  validates :crime_name, :sentence, presence: true
  validates :sentence, numericality: { only_integer: true }
  validates :ij_decision_date, presence:true, allow_blank: true
  validate :ij_decision_date_is_date?,
           :ij_decision_date_cannot_be_in_the_future
  validates :id, uniqueness: true
  before_create :set_number

  accepts_nested_attributes_for :conviction_grounds

  def ij_decision_date_is_date?
    if ij_decision_date.present? && !ij_decision_date.respond_to?(:strftime)
      errors.add(:ij_decision_date, "must be a valid date")
    end
  end

  def ij_decision_date_cannot_be_in_the_future
    if ij_decision_date.present? && ij_decision_date > Date.today
      errors.add(:ij_decision_date, "can't be in the future")
    end
  end

  def set_number
    while !self.id || Conviction.exists?(id: self.id.to_s)
      self.id = create_number
    end
  end

  def create_number
    (SecureRandom.random_number(9000000) + 1000000).to_s
  end
end
