FactoryGirl.define do
  factory :publicity do
    organisation { Faker::Company.name }
    statement { Faker::Lorem.paragraph }
    avatar {  File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
  end
end