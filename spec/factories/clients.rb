FactoryBot.define do
  factory :client do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "password" }
    address { Faker::Address.street_name }
    company { Faker::Company.name }
    terms_accepted { true }
  end
end
