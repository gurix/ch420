require 'rails_helper'

RSpec.describe "network/signature_collections/edit", type: :view do
  before(:each) do
    @network_signature_collection = assign(:network_signature_collection, Network::SignatureCollection.create!(
      :location_name => "MyString",
      :location_zip => 1,
      :location_address => "MyString"
    ))
  end

  it "renders the edit network_signature_collection form" do
    render

    assert_select "form[action=?][method=?]", network_signature_collection_path(@network_signature_collection), "post" do

      assert_select "input#network_signature_collection_location_name[name=?]", "network_signature_collection[location_name]"

      assert_select "input#network_signature_collection_location_zip[name=?]", "network_signature_collection[location_zip]"

      assert_select "input#network_signature_collection_location_address[name=?]", "network_signature_collection[location_address]"
    end
  end
end
