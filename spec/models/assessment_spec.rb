require 'rails_helper'

RSpec.describe Assessment, :type => :model do
  describe "validations" do
    let(:assessment) { Assessment.create(date: Date.today, client_id: 4) }
    context "date" do
      it "must have a value" do
        assessment.date = nil
        expect(assessment.valid?).to eq false
      end

      it "must be a date object" do
        assessment.date = "Jan 4"
        expect(assessment.valid?).to eq false
      end

      it "cannot be in the future" do
        assessment.date = Date.today + 1
        expect(assessment.valid?).to eq false
      end
    end

    context "client association" do
      it "must be associated with a client" do
        assessment.client_id = nil
        expect(assessment.valid?).to eq false
      end
    end

    # context "date and client association combination" do
    #   it "must be unique" do
    #     expect(assessment.valid?).to eq true
    #     invalid_assessment = Assessment.new(date: Date.today, client_id: 4)
    #     expect(invalid_assessment.valid?).to eq false
    #   end
    # end

  # it "has unique pair of date and client_id" do
  #   expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq true
  #   expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq false
  # end

  # it "has unique pair of date and client_id" do
  #   expect(Assessment.create(date: Date.today - 1, client_id: 2).valid?).to eq true
  #   expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq true
  # end
  #
  # it "has unique pair of date and client_id" do
  #   expect(Assessment.create(date: Date.today, client_id: 2).valid?).to eq true
  #   expect(Assessment.create(date: Date.today, client_id: 3).valid?).to eq true
  # end
  end
end
