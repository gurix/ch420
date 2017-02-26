class CitiesAutocompleteController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @cities = CSV.read Rails.root.join('db', 'plz_ch.csv')
    query = ActionController::Base.helpers.sanitize(params[:query])
    @cities = @cities.select { |city| city.first =~ /#{query}/i || city.last =~ /#{query}/i }
    @cities = @cities.map { |city| { plz: city.first, city: city.last } }

    render json: @cities.uniq
  end
end
