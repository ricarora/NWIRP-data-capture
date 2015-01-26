require "rails_helper"

RSpec.describe ConvictionGroundsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/conviction_grounds").to route_to("conviction_grounds#index")
    end

    it "routes to #new" do
      expect(:get => "/conviction_grounds/new").to route_to("conviction_grounds#new")
    end

    it "routes to #show" do
      expect(:get => "/conviction_grounds/1").to route_to("conviction_grounds#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/conviction_grounds/1/edit").to route_to("conviction_grounds#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/conviction_grounds").to route_to("conviction_grounds#create")
    end

    it "routes to #update" do
      expect(:put => "/conviction_grounds/1").to route_to("conviction_grounds#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/conviction_grounds/1").to route_to("conviction_grounds#destroy", :id => "1")
    end

  end
end
