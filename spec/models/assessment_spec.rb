require 'rails_helper'

RSpec.describe Assessment, :type => :model do
  it "must have a date" do
    expect(Assessment.create(date: nil, client_id: 4).valid?).to eq false
  end

  it "must have a client_id" do
    expect(Assessment.create(date: Date.parse("2015-01-27"), client_id: nil).valid?).to eq false
  end

  it "date must be date object" do
    expect(Assessment.create(date: "Jan 4", client_id: 4).valid?).to eq false
  end

  it "date can not be in the future" do
    expect(Assessment.create(date: Date.today + 1, client_id: 2).valid?).to eq false
  end

  it "has unique pair of date and client_id" do
    expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq true
    expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq false
  end

  it "has unique pair of date and client_id" do
    expect(Assessment.create(date: Date.today - 1, client_id: 2).valid?).to eq true
    expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq true
  end

  it "has unique pair of date and client_id" do
    expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq true
    expect(Assessment.create(date: Date.today, client_id: 3).valid?).to eq true
  end
end
