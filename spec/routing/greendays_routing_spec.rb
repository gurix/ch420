require "rails_helper"

RSpec.describe GreendaysController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/greendays").to route_to("greendays#index")
    end

    it "routes to #new" do
      expect(:get => "/greendays/new").to route_to("greendays#new")
    end

    it "routes to #show" do
      expect(:get => "/greendays/1").to route_to("greendays#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/greendays/1/edit").to route_to("greendays#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/greendays").to route_to("greendays#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/greendays/1").to route_to("greendays#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/greendays/1").to route_to("greendays#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/greendays/1").to route_to("greendays#destroy", :id => "1")
    end

  end
end
