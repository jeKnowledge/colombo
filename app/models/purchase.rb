class Purchase < ApplicationRecord
  belongs_to :report
  belongs_to :client
  belongs_to :auditor

  validates_presence_of :price
end
