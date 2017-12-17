require 'rails_helper'

RSpec.describe "network/signature_collections/show", type: :view do
  before(:each) do
    @network_signature_collection = assign(:network_signature_collection, Network::SignatureCollection.create!(
      :location_name => "Location Name",
      :location_zip => 2,
      :location_address => "Location Address"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Location Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Location Address/)
  end
end
