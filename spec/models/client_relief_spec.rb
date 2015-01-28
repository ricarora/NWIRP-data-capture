require 'rails_helper'

RSpec.describe ClientRelief, :type => :model do
  it "client_id must be an integer" do
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: "four").valid?).to eq false
  end

  it "client_id and relief_name must be unique combination" do
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 4).valid?).to eq true
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 4).valid?).to eq false
  end

  it "client_id and relief_name must be unique combination" do
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 4).valid?).to eq true
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 5).valid?).to eq true
  end

  it "client_id and relief_name must be unique combination" do
    expect(ClientRelief.create(relief_name: "LPR", client_id: 4).valid?).to eq true
    expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 4).valid?).to eq true
  end
end
