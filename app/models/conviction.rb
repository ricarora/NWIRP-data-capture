class Conviction < ActiveRecord::Base
  belongs_to :client
  has_many :removability_grounds, through: :conviction_grounds
  has_many :conviction_grounds, autosave: true
  validates :crime_name, presence: true
  validates :sentence, numericality: { only_integer: true }
  validates :ij_decision_date, presence:true, allow_blank: true
  validate :ij_decision_date_is_date?,
           :ij_decision_date_cannot_be_in_the_future
  accepts_nested_attributes_for :conviction_grounds
  attr_accessor :sentence_unit

  IJ_NAME = ["Odell", "Scala", "Fitting"]

  STATE_COMMITTED = ["Washington", "Alabama", "Alaska", "Arizona", "Arkansas", "California",
    "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho",
    "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine",
    "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
    "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico",
    "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
    "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
    "Texas", "Utah", "Vermont", "Virginia", "West Virginia", "Wisconsin", "Wyoming"]

  validates :ij_name, :inclusion => {:in => Conviction::IJ_NAME, allow_blank: true}
  validates :state_committed, :inclusion => {:in => Conviction::STATE_COMMITTED, allow_blank: true}

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

  ransacker :title_diddly do |parent|
    Arel::Nodes::InfixOperation.new('||', parent.table[:title], '-diddly')
  end

  def self.all_crime_names
    Conviction.select(:crime_name).map(&:crime_name).uniq.reject(&:empty?)
  end

  def self.all_subsections
    Conviction.select(:subsection).map(&:subsection).uniq#.reject {|subsection| subsection == ""}
  end

  def self.all_nta_charges
    Conviction.select(:nta_charges).map(&:nta_charges).uniq#.reject {|nta_charge| nta_charge == ""}
  end
end
