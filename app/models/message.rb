class Message < ApplicationRecord
  belongs_to :conversation

  attr_accessor :client_audit_ids

  scope :paginate, -> (page, per_page) { page(page).per(per_page) }

  validates_presence_of :conversation, :body
  validates_inclusion_of :direction, :in => [true, false]
end
