require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  describe "GET #advance_search" do
    it "returns http success" do
      get :advance_search
      expect(response).to have_http_status(:success)
    end
  end

end
