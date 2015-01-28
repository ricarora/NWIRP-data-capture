require 'rails_helper'

RSpec.describe ClientRelief, :type => :model do
  it "client_id must be an integer" do
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: "four").valid?).to eq false
  end
end
