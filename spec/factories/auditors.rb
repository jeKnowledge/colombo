FactoryBot.define do
  factory :auditor do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "password" }
    qualifications { Faker::Job.key_skill }
    cv { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/resume.pdf')) }
    address { Faker::Address.street_name }
    company { Faker::Company.name }
    terms_accepted { true }
  end
end
