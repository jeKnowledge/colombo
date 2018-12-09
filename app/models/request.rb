class Request < ApplicationRecord
  self.table_name = "audit_requests"
  before_create :set_as_validated

  belongs_to :client

  validates_presence_of :client, :company, :address, :products, :date

  def set_as_validated
    self.validated = true
  end
end
