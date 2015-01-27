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
  end
end
