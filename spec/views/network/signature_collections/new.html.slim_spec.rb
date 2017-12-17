require 'rails_helper'

RSpec.describe "network/signature_collections/new", type: :view do
  before(:each) do
    assign(:network_signature_collection, Network::SignatureCollection.new(
      :location_name => "MyString",
      :location_zip => 1,
      :location_address => "MyString"
    ))
  end

  it "renders new network_signature_collection form" do
    render

    assert_select "form[action=?][method=?]", network_signature_collections_path, "post" do

      assert_select "input#network_signature_collection_location_name[name=?]", "network_signature_collection[location_name]"

      assert_select "input#network_signature_collection_location_zip[name=?]", "network_signature_collection[location_zip]"

      assert_select "input#network_signature_collection_location_address[name=?]", "network_signature_collection[location_address]"
    end
  end
end
