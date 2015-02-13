require 'rails_helper'

RSpec.describe ClientRelief, :type => :model do
  describe "validations" do
    let(:client_relief) { ClientRelief.create(relief_name: "10 YR COR" , client_id: 4) }
    context "associations" do
      it "must be associated with client" do
        expect(client_relief.valid?).to eq true
        client_relief.client_id = nil
        expect(client_relief.valid?).to eq false
      end
    end

    context "relief_name and client_id combination" do
      # it "must be unique" do
      #   expect(ClientRelief.create(relief_name: "10 yr COR", client_id: client.id).valid?).to eq true
      #expect(ClientRelief.create(relief_name: "10 yr COR", client_id: client.id).valid?).to eq false
      # end
      #
      # it "client_id and relief_name must be unique combination" do
      #   expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 4).valid?).to eq true
      #   expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 5).valid?).to eq true
      # end
      #
      # it "client_id and relief_name must be unique combination" do
      #   expect(ClientRelief.create(relief_name: "LPR", client_id: 4).valid?).to eq true
      #   expect(ClientRelief.create(relief_name: "10 yr COR", client_id: 4).valid?).to eq true
      # end
    end
  end
end
