FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "password" }
    terms_of_service { true }
  end
end
