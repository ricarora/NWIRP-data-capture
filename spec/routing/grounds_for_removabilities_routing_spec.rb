require "rails_helper"

RSpec.describe GroundsForRemovabilitiesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/grounds_for_removabilities").to route_to("grounds_for_removabilities#index")
    end

    it "routes to #new" do
      expect(:get => "/grounds_for_removabilities/new").to route_to("grounds_for_removabilities#new")
    end

    it "routes to #show" do
      expect(:get => "/grounds_for_removabilities/1").to route_to("grounds_for_removabilities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/grounds_for_removabilities/1/edit").to route_to("grounds_for_removabilities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/grounds_for_removabilities").to route_to("grounds_for_removabilities#create")
    end

    it "routes to #update" do
      expect(:put => "/grounds_for_removabilities/1").to route_to("grounds_for_removabilities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/grounds_for_removabilities/1").to route_to("grounds_for_removabilities#destroy", :id => "1")
    end

  end
end
