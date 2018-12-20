require 'factory_bot'

FactoryBot.find_definitions

FactoryBot.create :admin, username: "admin"

FactoryBot.create :auditor, email: "tiagomartins282@gmail.com"

2.times do
  FactoryBot.create :auditor
end

2.times do
  FactoryBot.create :client
end

FactoryBot.create :request
FactoryBot.create :report
FactoryBot.create :plan

FactoryBot.create :consent

FactoryBot.create :purchase
FactoryBot.create :reservation
