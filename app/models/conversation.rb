class Conversation < ApplicationRecord
  belongs_to :auditor
  has_many :messages

  validates_presence_of :subject
  validates_length_of :subject, minimum: 5, maximum: 255, allow_blank: false
end
