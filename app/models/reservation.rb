class Reservation < ApplicationRecord
  belongs_to :plan
  belongs_to :client
  belongs_to :auditor

  validates_presence_of :price
end
