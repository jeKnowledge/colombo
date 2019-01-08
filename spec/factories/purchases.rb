FactoryBot.define do
  factory :purchase do
    price { Faker::Number.decimal(2) }
    report { FactoryBot.create(:report) }
    client { FactoryBot.create(:client) }
    auditor { FactoryBot.create(:auditor) }
  end
end
