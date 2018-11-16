FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    password { "password" }
    address { Faker::Address.street_name }
    company { Faker::Company.name }
    terms_accepted { true }
  end
end
