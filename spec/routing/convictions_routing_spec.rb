require "rails_helper"

RSpec.describe ConvictionsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/convictions").to route_to("convictions#index")
    end

    it "routes to #new" do
      expect(:get => "/convictions/new").to route_to("convictions#new")
    end

    it "routes to #show" do
      expect(:get => "/convictions/1").to route_to("convictions#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/convictions/1/edit").to route_to("convictions#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/convictions").to route_to("convictions#create")
    end

    it "routes to #update" do
      expect(:put => "/convictions/1").to route_to("convictions#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/convictions/1").to route_to("convictions#destroy", :id => "1")
    end

  end
end
