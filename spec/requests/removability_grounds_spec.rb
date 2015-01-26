require 'rails_helper'

RSpec.describe "RemovabilityGrounds", :type => :request do
  describe "GET /removability_grounds" do
    it "works! (now write some real specs)" do
      get removability_grounds_path
      expect(response).to have_http_status(200)
    end
  end
end
