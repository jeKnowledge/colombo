FactoryBot.define do
  factory :message do
    direction { [true, false].sample }
    body { Faker::Lorem.sentence }
  end
end
