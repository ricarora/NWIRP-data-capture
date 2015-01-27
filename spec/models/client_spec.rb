require 'rails_helper'

RSpec.describe Client, :type => :model do
  let(:client) { FactoryGirl.create(:client) }
  describe ".validations" do
    it "must have a first name" do
      invalid_client = Client.create(first_name: nil)
      expect((invalid_client).valid?).to eq false
      expect((client).valid?).to eq true
    end

    it "must have a last name" do
      invalid_client = Client.create(first_name: "Miguel", last_name: nil)
      expect((invalid_client).valid?).to eq false
      expect((client).valid?).to eq true
    end
  end
end
