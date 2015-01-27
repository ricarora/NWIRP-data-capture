require 'rails_helper'

RSpec.describe Conviction, :type => :model do
  let(:conviction) { FactoryGirl.create(:conviction) }
  context "must have a crime_name" do
    subject { FactoryGirl.build(:conviction, crime_name: nil)}
    it { should_not be_valid }
  end

  context "must have a sentence" do
    subject { FactoryGirl.build(:conviction, sentence: nil)}
    it { should_not be_valid }
  end

  context "sentence can not be a string" do
    subject { FactoryGirl.build(:conviction, sentence: "ten")}
    it { should_not be_valid }
    it "must be an integer" do
      expect((conviction).valid?).to eq true
    end
  end

  context "ij decision date must be a date object" do
    subject { FactoryGirl.build(:conviction, ij_decision_date: "Jan 4")}
    it { should_not be_valid }
  end
end
