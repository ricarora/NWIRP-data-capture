require 'rails_helper'

RSpec.describe Client, :type => :model do
  let(:client) { FactoryGirl.create(:client) }
  describe ".validations" do
    it "must have a first name" do
      client = FactoryGirl.create(:client, first_name: nil)
      expect((client).valid?).to eq false
    end
  end
end
