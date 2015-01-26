require 'rails_helper'

RSpec.describe "GroundsForRemovabilities", :type => :request do
  describe "GET /grounds_for_removabilities" do
    it "works! (now write some real specs)" do
      get grounds_for_removabilities_path
      expect(response).to have_http_status(200)
    end
  end
end
