require 'factory_bot'

FactoryBot.find_definitions

FactoryBot.create :contract
FactoryBot.create :term

FactoryBot.create :admin
2.times { FactoryBot.create :auditor }
2.times { FactoryBot.create :client }

FactoryBot.create :request
FactoryBot.create :report
FactoryBot.create :plan

FactoryBot.create :purchase
FactoryBot.create :reservation
