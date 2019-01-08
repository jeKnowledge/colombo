FactoryBot.define do
  factory :request do
    company { Faker::Company.name }
    address { Faker::Address.street_name }
    date { Time.now + 2.weeks }
    products { Faker::Lorem.sentence(3) }
    client { FactoryBot.create(:client) }
  end
end
