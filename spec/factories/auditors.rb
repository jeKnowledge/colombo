FactoryBot.define do
  factory :auditor do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    password { "Password#2018" }
    password_confirmation { "Password#2018" }
    qualifications { Faker::Job.key_skill }
    cv { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/resume.pdf')) }
    address { Faker::Address.street_name }
    company { Faker::Company.name }
    terms_of_service { true }
  end
end
