FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    password { "password" }
    terms_accepted { true }
  end
end
