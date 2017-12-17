class Network::SignatureCollection
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :location_name, type: String
  field :location_zip, type: Integer
  field :location_zip_s, type: String
  field :location_address, type: String
  field :event_date_start, type: Time
  field :event_date_end, type: Time
  field :coordinates, type: Array

  geocoded_by :address
  before_save :update_location # auto-fetch coordinates
  before_save :stringify_zip # auto-fetch coordinates

  def address
    "#{location_zip} #{location_name}, Switzerland"
  end

  def update_location
    geocode
  end

  def stringify_zip
    self.location_zip_s = self.location_zip.to_s
  end

  index({coordinates: "2d"})
end
