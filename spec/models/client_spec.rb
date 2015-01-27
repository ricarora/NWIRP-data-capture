require 'rails_helper'

RSpec.describe Client, :type => :model do
  let(:user) { FactoryGirl.create(:user) }
  describe ".validations" do
    it "must have a first name" do
      user = FactoryGirl.create(:user, first_name: nil)
      expect((user).valid?).to eq false
    end
  end
end
