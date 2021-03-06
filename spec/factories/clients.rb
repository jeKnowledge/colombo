FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "Password#2018" }
    password_confirmation { "Password#2018" }
    address { Faker::Address.street_name }
    company { Faker::Company.name }
    country { Faker::Address.country_code }
  end
end
