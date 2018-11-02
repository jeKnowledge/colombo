FactoryBot.define do
  factory :reservation do
    price {  Faker::Number.decimal(2) }
    plan { FactoryBot.create(:plan) }
    client { FactoryBot.create(:client) }
    auditor { FactoryBot.create(:auditor) }
  end
end
