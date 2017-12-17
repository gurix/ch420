# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@cities = CSV.read Rails.root.join('db', 'plz_ch.csv')
@cities.sample(122).each do |city|
  tmp_date = DateTime.now + rand(50)
  Network::SignatureCollection.create(location_zip: city.first, location_name: city.last, location_address: Faker::Address.street_address, event_date_start: tmp_date, event_date_end: tmp_date+rand(10).to_f/10)
end

#  Network::SignatureCollection.where(location: {"$near" => x.location,  '$maxDistance' => 1.fdiv(111.12)}).map &:location_name
