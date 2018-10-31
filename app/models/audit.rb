class Audit < ApplicationRecord
  has_many :reports
  has_many :plans
  validates_presence_of :site, :address, :date, :products
end
