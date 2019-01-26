FactoryBot.define do
  factory :conversation do
    auditor { Auditor.all.sample }
    subject { Faker::Lorem.characters(10) }

    factory :conversation_with_messages do
      transient do
        messages_count { 10 }
      end

      after(:create) do |conversation, evaluator|
        create_list(:message, evaluator.messages_count, conversation: conversation)
      end
    end
  end
end
