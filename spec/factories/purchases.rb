FactoryBot.define do
  factory :purchase do
    price { Faker::Number.decimal(2) }
    report { Report.all.sample }
    client { Client.all.sample }
    auditor { Auditor.all.sample }
  end
end
