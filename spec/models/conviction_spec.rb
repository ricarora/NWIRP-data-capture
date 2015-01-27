require 'rails_helper'

RSpec.describe Conviction, :type => :model do
  context "must have a crime_name" do
    subject { FactoryGirl.build(:conviction, crime_name: nil)}
    it { should_not be_valid }
  end
end
