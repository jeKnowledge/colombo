FactoryBot.define do
  factory :request do
    site { Faker::Internet.domain_name }
    address { Faker::Address.street_name }
    date { Faker::Date.between(2.days.ago, Date.today) }
    products { Faker::Lorem.sentence(3) }
    client { FactoryBot.create(:client) }
  end
end
