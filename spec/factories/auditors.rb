FactoryBot.define do
  factory :auditor do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.first_name }
    password { "password" }
    qualifications { Faker::Job.key_skill }
    cv { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/resume.pdf')) }
    address { Faker::Address.street_name }
    company { Faker::Company.name }
  end
end
