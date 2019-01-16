FactoryBot.define do
  factory :report do
    products { Faker::Lorem.sentence(3) }
    auditor { Auditor.all.sample }
    price { Faker::Number.decimal(2) }
    report { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/resume.pdf')) }
    summary { Faker::Lorem.sentence(3) }
    fee { Faker::Number.decimal(2) }
  end
end
