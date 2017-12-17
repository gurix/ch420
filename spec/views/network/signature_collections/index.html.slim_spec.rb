require 'rails_helper'

RSpec.describe "network/signature_collections/index", type: :view do
  before(:each) do
    assign(:network_signature_collections, [
      Network::SignatureCollection.create!(
        :location_name => "Location Name",
        :location_zip => 2,
        :location_address => "Location Address"
      ),
      Network::SignatureCollection.create!(
        :location_name => "Location Name",
        :location_zip => 2,
        :location_address => "Location Address"
      )
    ])
  end

  it "renders a list of network/signature_collections" do
    render
    assert_select "tr>td", :text => "Location Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Location Address".to_s, :count => 2
  end
end
