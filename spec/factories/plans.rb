FactoryBot.define do
  factory :plan do
    date { Time.now + 2.weeks }
    products { Faker::Lorem.sentence(3) }
    summary { Faker::Lorem.sentence(3) }
    auditor { Auditor.all.sample }
    price { Faker::Number.decimal(2) }
    fee { Faker::Number.decimal(2) }
  end
end
