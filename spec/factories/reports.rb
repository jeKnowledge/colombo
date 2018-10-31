FactoryBot.define do
  factory :report do
    site { Faker::Internet.domain_name }
    address { Faker::Address.street_name }
    products { Faker::Lorem.sentence(3) }
    auditor { FactoryBot.create(:auditor) }
  end
end
