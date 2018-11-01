FactoryBot.define do
  factory :report do
    products { Faker::Lorem.sentence(3) }
    auditor { FactoryBot.create(:auditor) }
    price { Faker::Number.decimal(2) }
    report { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/resume.pdf')) }
    summary { Faker::Lorem.sentence(3) }
  end
end
