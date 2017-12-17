require "rails_helper"

RSpec.describe Network::SignatureCollectionsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/network/signature_collections").to route_to("network/signature_collections#index")
    end

    it "routes to #new" do
      expect(:get => "/network/signature_collections/new").to route_to("network/signature_collections#new")
    end

    it "routes to #show" do
      expect(:get => "/network/signature_collections/1").to route_to("network/signature_collections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/network/signature_collections/1/edit").to route_to("network/signature_collections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/network/signature_collections").to route_to("network/signature_collections#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/network/signature_collections/1").to route_to("network/signature_collections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/network/signature_collections/1").to route_to("network/signature_collections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/network/signature_collections/1").to route_to("network/signature_collections#destroy", :id => "1")
    end

  end
end
