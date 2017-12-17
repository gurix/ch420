class Network::SignatureCollection
  include Mongoid::Document
  field :location_name, type: String
  field :location_zip, type: Integer
  field :location_address, type: String
  field :event_date_start, type: Time
  field :event_date_end, type: Time
end
