FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "password" }
    terms_accepted { true }
  end
end
