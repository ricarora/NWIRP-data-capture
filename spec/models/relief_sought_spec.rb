require 'rails_helper'

RSpec.describe ReliefSought, :type => :model do
  it "name must be present" do
    expect(ReliefSought.create(name: "").valid?).to eq false
  end

  it "name must be unique" do
    expect(ReliefSought.create(name: "10 yrs COR").valid?).to eq true
    expect(ReliefSought.create(name: "10 yrs COR").valid?).to eq false
  end

  it "name must be case insensitive" do
    expect(ReliefSought.create(name: "10 yrs COR").valid?).to eq true
    expect(ReliefSought.create(name: "10 yrs coR").valid?).to eq false
  end
end
