FactoryBot.define do
  factory :reservation do
    price {  Faker::Number.decimal(2) }
    plan { Plan.all.sample }
    client { Client.all.sample }
    auditor { Auditor.all.sample }
  end
end
