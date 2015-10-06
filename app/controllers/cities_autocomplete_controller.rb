class CitiesAutocompleteController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @cities = CSV.read Rails.root.join('db', 'plz_ch.csv')

    @cities = @cities.select { |city| city.first =~ /#{params[:query]}/i || city.last =~ /#{params[:query]}/i  }
    @cities = @cities.map { |city| { plz: city.first, city: city.last } }

    render json: @cities.uniq
  end
end
