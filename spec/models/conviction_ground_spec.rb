require 'rails_helper'

RSpec.describe ConvictionGround, :type => :model do
  it "status can not be arbitrary" do
    expect(ConvictionGround.create(gor_name: "DV", conviction_id: 4, status: "whatever").valid?).to eq false
  end

  it "gor_name & conviction id must be a unique pair" do
    expect(ConvictionGround.create(gor_name: "DV", conviction_id: 4, status: "Yes").valid?).to eq true
    expect(ConvictionGround.create(gor_name: "DV", conviction_id: 4, status: "Yes").valid?).to eq false
  end
end
