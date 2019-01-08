FactoryBot.define do
  factory :consent do
    type_id { Faker::Number.between(0, 2) }
    description { Faker::Lorem.sentence(3) }
  end
end
