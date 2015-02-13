require 'rails_helper'

RSpec.describe ConvictionGround, :type => :model do
  describe "validations" do
    let(:conviction_ground) { ConvictionGround.create(gor_name: "DV", conviction_id: 4, status: "Yes") }
    context "status" do
      it "must be either Yes, No or Finding Not Made" do
        expect(conviction_ground.valid?).to eq true
        conviction_ground.status = "Yep"
        expect(conviction_ground.valid?).to eq false
        conviction_ground.status = "Finding Not Made"
        expect(conviction_ground.valid?).to eq true
      end
    end

    context "gor_name and conviction_id combination" do
      it "must be unique" do
        conviction_ground
        invalid_conviction_ground = ConvictionGround.new(gor_name: "DV", conviction_id: 4, status: "No")
        expect(invalid_conviction_ground.valid?).to eq false
      end
    end
  end
end
