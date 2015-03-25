# Copyright (c) 2015 Richa Arora and Kate Fulton All Rights Reserved.


class Conviction < ActiveRecord::Base
  belongs_to :client
  has_many :removability_grounds, through: :conviction_grounds
  has_many :conviction_grounds, autosave: true
  validates :crime_name, presence: true
  validates :sentence, numericality: { only_integer: true, allow_blank: true }
  validates :dv_on_roc, inclusion: {in: [true, false], allow_blank: true}
  validates :ij_decision_date, presence:true, allow_blank: true
  validate :ij_decision_date_is_date?,
           :ij_decision_date_cannot_be_in_the_future
  accepts_nested_attributes_for :conviction_grounds,
      :reject_if => proc {|attributes|
        attributes.all? {|k,v| v.blank?}
      }

  attr_accessor :sentence_unit

  STATE_COMMITTED = ["Washington", "Alabama", "Alaska", "Arizona", "Arkansas", "California",
    "Colorado", "Connecticut", "Delaware", "Florida", "Georgia", "Hawaii", "Idaho",
    "Illinois", "Indiana", "Iowa", "Kansas", "Kentucky", "Louisiana", "Maine",
    "Maryland", "Massachusetts", "Michigan", "Minnesota", "Mississippi", "Missouri",
    "Montana", "Nebraska", "Nevada", "New Hampshire", "New Jersey", "New Mexico",
    "New York", "North Carolina", "North Dakota", "Ohio", "Oklahoma", "Oregon",
    "Pennsylvania", "Rhode Island", "South Carolina", "South Dakota", "Tennessee",
    "Texas", "Utah", "Vermont", "Virginia", "West Virginia", "Wisconsin", "Wyoming"]

  validates :ij_name, :inclusion => {:in => Judge.all.map {|j| j.name}, allow_blank: true}
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

  def self.to_csv(list, options = {})
    column_names = ["crime_name",
                    "state_committed",
                    "statute_of_conviction",
                    "subsection", "sentence",
                    "sentence_type",
                    "nta_charges",
                    "dv_on_roc",
                    "ij_name",
                    "ij_decision_date",
                    "ij_finding",
                    "notes"]
    CSV.generate(options) do |csv|
      csv << column_names
      list.each do |conviction|
        csv << conviction.attributes.values_at(*column_names)
      end
    end
  end

  def DV_ON_ROC
    self.dv_on_roc ? "Yes" : "No"
  end

  def self.all_crime_names
    Conviction.select(:crime_name).map(&:crime_name).uniq.reject(&:blank?)
  end

  def self.all_subsections
    Conviction.select(:subsection).map(&:subsection).uniq.reject(&:blank?)
  end

  def self.all_nta_charges
    Conviction.select(:nta_charges).map(&:nta_charges).uniq.reject(&:blank?)
  end

  def self.ransackable_attributes(auth_object = nil)
    %w(crime_name statute_of_conviction subsection sentence sentence_type ij_name nta_charges ij_decision_date ij_finding notes) + _ransackers.keys
  end
end
