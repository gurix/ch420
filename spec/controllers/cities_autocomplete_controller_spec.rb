require 'rails_helper'

describe CitiesAutocompleteController do
  describe 'GET index' do
    it 'searchs for cities' do
      get :index, query: 'spei', format: :js

      result = JSON.parse response.body
      expect(result).to eq [{ 'plz' => '9042', 'city' => 'Speicher' }, { 'plz' => '9037', 'city' => 'Speicherschwendi' }]
    end
  end
end
