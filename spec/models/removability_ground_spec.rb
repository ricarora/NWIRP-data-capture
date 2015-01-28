require 'rails_helper'

RSpec.describe RemovabilityGround, :type => :model do
  let(:removability) { RemovabilityGround.create(:name => "DV") }
  context "The removability ground has a name." do
    it "name is present" do
      removability.update(name: "")
      expect((removability).valid?).to eq false
    end
    
    it "name is unique" do
      expect((removability).valid?).to eq true
      invalid_ground = RemovabilityGround.create(name: "DV")
      expect((invalid_ground).valid?).to eq false
    end

    it "name is case insensitive" do
      expect((removability).valid?).to eq true
      invalid_ground = RemovabilityGround.create(name: "dv")
      expect((invalid_ground).valid?).to eq false
    end
  end
end
