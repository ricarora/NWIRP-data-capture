require 'rails_helper'

RSpec.describe ReliefSought, :type => :model do
  let(:relief_sought) { ReliefSought.create(name: "10 YRS COR")}
  describe "validations" do
    let(:relief_sought) { ReliefSought.create(name: "10 YRS COR")}
    context "relief name" do
      it "name must be present" do
        relief_sought.name = ""
        expect(relief_sought.valid?).to eq false
      end

      it "name must be unique" do
        expect(relief_sought.valid?).to eq true
        expect(ReliefSought.create(name: "10 YRS COR").valid?).to eq false
      end

      it "name must be case insensitive" do
        expect(relief_sought.valid?).to eq true
        expect(ReliefSought.create(name: "10 yrs coR").valid?).to eq false
      end
    end
  end
end
