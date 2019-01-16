require 'factory_bot'

FactoryBot.find_definitions

FactoryBot.create :admin
FactoryBot.create_list(:auditor, 5)
FactoryBot.create_list(:client, 5)

FactoryBot.create_list(:request, 5)
FactoryBot.create_list(:report, 5)
FactoryBot.create_list(:plan, 5)

FactoryBot.create_list(:consent, 5)

FactoryBot.create_list(:purchase, 5)
FactoryBot.create_list(:reservation, 5)

FactoryBot.create_list(:conversation_with_messages, 10)
