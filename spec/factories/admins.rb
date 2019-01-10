FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "Password#2018" }
    password_confirmation { "Password#2018" }
  end
end
