require 'rails_helper'

RSpec.describe "greendays/new", type: :view do
  before(:each) do
    assign(:greenday, Greenday.new(
      :title => "MyString",
      :address => "MyText",
      :description => "MyText"
    ))
  end

  it "renders new greenday form" do
    render

    assert_select "form[action=?][method=?]", greendays_path, "post" do

      assert_select "input#greenday_title[name=?]", "greenday[title]"

      assert_select "textarea#greenday_address[name=?]", "greenday[address]"

      assert_select "textarea#greenday_description[name=?]", "greenday[description]"
    end
  end
end
