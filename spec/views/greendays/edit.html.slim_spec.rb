require 'rails_helper'

RSpec.describe "greendays/edit", pending: true, type: :view do
  before(:each) do
    @greenday = assign(:greenday, Greenday.create!(
      :title => "MyString",
      :address => "MyText",
      :description => "MyText"
    ))
  end

  it "renders the edit greenday form" do
    render

    assert_select "form[action=?][method=?]", greenday_path(@greenday), "post" do

      assert_select "input#greenday_title[name=?]", "greenday[title]"

      assert_select "textarea#greenday_address[name=?]", "greenday[address]"

      assert_select "textarea#greenday_description[name=?]", "greenday[description]"
    end
  end
end
