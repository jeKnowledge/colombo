FactoryBot.define do
  factory :plan do
    date { Time.now + 2.weeks }
    products { Faker::Lorem.sentence(3) }
    summary { Faker::Lorem.sentence(3) }
    auditor { FactoryBot.create(:auditor) }
  end
end
