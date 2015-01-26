require "rails_helper"

RSpec.describe RemovabilityGroundsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/removability_grounds").to route_to("removability_grounds#index")
    end

    it "routes to #new" do
      expect(:get => "/removability_grounds/new").to route_to("removability_grounds#new")
    end

    it "routes to #show" do
      expect(:get => "/removability_grounds/1").to route_to("removability_grounds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/removability_grounds/1/edit").to route_to("removability_grounds#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/removability_grounds").to route_to("removability_grounds#create")
    end

    it "routes to #update" do
      expect(:put => "/removability_grounds/1").to route_to("removability_grounds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/removability_grounds/1").to route_to("removability_grounds#destroy", :id => "1")
    end

  end
end
