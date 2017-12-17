require 'rails_helper'

RSpec.describe "Network::SignatureCollections", type: :request do
  describe "GET /network_signature_collections" do
    it "works! (now write some real specs)" do
      get network_signature_collections_path
      expect(response).to have_http_status(200)
    end
  end
end
