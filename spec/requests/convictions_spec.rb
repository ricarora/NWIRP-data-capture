require 'rails_helper'

RSpec.describe "Convictions", :type => :request do
  describe "GET /convictions" do
    it "works! (now write some real specs)" do
      get convictions_path
      expect(response).to have_http_status(200)
    end
  end
end
