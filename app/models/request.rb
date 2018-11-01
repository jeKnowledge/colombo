class Request < ApplicationRecord
  self.table_name = "audit_requests"

  belongs_to :client

  validates_presence_of :client, :company, :address, :products, :date
end
