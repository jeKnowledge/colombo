class Audit < ApplicationRecord
  validates_presence_of :site, :address, :date, :products, :validated
end
