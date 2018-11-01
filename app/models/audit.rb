class Audit < ApplicationRecord
  has_many :reports
  has_many :plans
  
  validates_presence_of :address, :products, :date, :products
end
