FactoryGirl.define do
  factory :supporter do
    email { Faker::Internet.email }
    password { Faker::Lorem.words(8).join }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    street { Faker::Address.street_name }
    zip { Faker::Address.zip }
    city { Faker::Address.city }
    support { %w(signer supporter).sample }
    age_category { %w(underage young middle retired).sample }
    language { %w(de fr it).sample } 
  end
end