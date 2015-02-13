require 'rails_helper'

RSpec.describe Conviction, :type => :model do
  describe "validations" do
    let(:conviction) { Conviction.create(crime_name: "Assault 3", client_id: 4)}

    context "crime_name" do
      it "must have a crime_name" do
        expect(conviction.valid?).to eq true
        conviction.crime_name = nil
        expect(conviction.valid?).to eq false
      end
    end

    context "crime sentence" do
      it "cannot be a string" do
        conviction.sentence = "ten days"
        expect(conviction.valid?).to eq false
      end

      it "must be an integer" do
        conviction.sentence = 10
        expect(conviction.valid?).to eq true
      end
    end

    context "Immigration Judge (IJ) decision date" do
      it "must be date object" do
        conviction.ij_decision_date = "Not a date"
        expect(conviction.ij_decision_date).to eq nil

        conviction.ij_decision_date = Date.today
        expect(conviction.ij_decision_date).to eq Date.today
        expect(conviction.save).to eq true
        expect(conviction.valid?).to eq true
      end

      it "must be a date on or before today" do
        conviction.ij_decision_date = Date.today + 1
        expect(conviction.save).to eq false
        expect(conviction.valid?).to eq false

        conviction.ij_decision_date = Date.today
        expect(conviction.save).to eq true
        expect(conviction.valid?).to eq true
      end
    end

    context "client_id" do
      it "conviction must be associated with client" do
        expect(conviction.save).to eq true
      end

      # it "is not valid without client association" do
      #   invalid_conviction = Conviction.new(crime_name: "Assault")
      #   expect(invalid_conviction.valid?).to eq false
      # end
    end
  end
end
