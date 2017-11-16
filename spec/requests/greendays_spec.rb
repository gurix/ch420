require 'rails_helper'

RSpec.describe "Greendays", type: :request do
  describe "GET /greendays" do
    it "works! (now write some real specs)" do
      get greendays_path
      expect(response).to have_http_status(200)
    end
  end
end
