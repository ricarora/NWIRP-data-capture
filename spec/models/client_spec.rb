require 'rails_helper'

RSpec.describe Client, :type => :model do
  let(:client) { Client.new(last_name: "Prince", a_number: "123-456-789") }
  let(:assessment) { Assesment.new(date: Date.new, client_id: client.id) }

  describe ".validations" do
    it "client must have a last name" do
      expect(client.valid?).to eq true
      client.last_name = nil
      expect(client.valid?).to eq true
    end
  end

  #
  #   context "gender can be either Male, Female, Unknown or Other" do
  #     subject { FactoryGirl.build(:client, gender: "Burrito") }
  #     it { should_not be_valid }
  #     subject { FactoryGirl.build(:client, gender: "Other") }
  #     it { should be_valid }
  #   end
  #
  #   context "must have an a_number" do
  #     subject { FactoryGirl.build(:client, a_number: nil)}
  #     it { should_not be_valid}
  #   end
  #
  #   it "the a_number must be unique" do
  #     expect((client).valid?).to eq true
  #     invalid_client = Client.create(last_name: "Contreras", a_number: "123-456-798")
  #     expect((invalid_client).valid?).to eq false
  #   end
  #
  #   context "must have valid nationality" do
  #     subject { FactoryGirl.build(:client, nationality: "Nothing") }
  #     it { should_not be_valid}
  #   end
  # end
end
