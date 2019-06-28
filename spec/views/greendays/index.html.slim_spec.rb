require 'rails_helper'

RSpec.describe 'greendays/index', pending: true do
  before(:each) do
    assign(:greendays, [
      Greenday.create!(
        title: 'Title',
        address: 'Address',
        description: 'MyText'
      ),
      Greenday.create!(
        title: 'Title',
        address: 'Address',
        description: 'MyText'
      )
    ])
  end

  it 'renders a list of greendays' do
    render
    assert_select 'h2', text: 'Title'.to_s, count: 2
    assert_select "address", :text => "Address".to_s, count: 2
    assert_select "p", :text => "MyText".to_s, count: 2
  end
end
