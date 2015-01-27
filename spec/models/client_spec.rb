require 'rails_helper'

RSpec.describe Client, :type => :model do
  let(:client) { FactoryGirl.create(:client) }
  describe ".validations" do
    it "must have a first name" do
      invalid_client = Client.create(first_name: nil, last_name: "Contreras")
      expect((invalid_client).valid?).to eq false
      expect((client).valid?).to eq true
    end

    context "must have a last name" do
      subject { FactoryGirl.build(:client, last_name: nil)}
      it { should_not be_valid }
    end

    context "must have a gender" do
      subject { FactoryGirl.build(:client, gender: nil) }
      it { should_not be_valid }
    end

    context "must be either Male or Female" do
      subject { FactoryGirl.build(:client, gender: "m") }
      it { should_not be_valid}
    end

    context "must have value in represented field" do
      subject { FactoryGirl.build(:client, represented: nil)}
      it { should_not be_valid}
    end

    context "represented field must be a boolean" do
      subject { FactoryGirl.build(:client, represented: "yes")}
      it { should_not be_valid}
      it "saves client with valid boolean" do
        expect((client).valid?).to eq true
      end
    end

    context "must have an a_number" do
      subject { FactoryGirl.build(:client, a_number: nil)}
      it { should_not be_valid}
    end

    it "the a_number must be unique" do
      expect((client).valid?).to eq true
      invalid_client = Client.create(first_name: "Miguel", last_name: "Contreras", gender: "Male", represented: true, a_number: "1234567", nationality: "Mexican")
      expect((invalid_client).valid?).to eq false
    end

    context "must have a nationality" do
      subject { FactoryGirl.build(:client, nationality: nil)}
      it { should_not be_valid}
    end
  end
end
