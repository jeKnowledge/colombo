class Audit < ApplicationRecord
  belongs_to :auditor

  scope :validated, -> { where(validated: true)}

  scope :paginate, -> (page, per_page) { page(page).per(per_page) }

  scope :products_like, -> (query) { where("products LIKE '%#{query}%'") }

  validates_presence_of :products, :date, :auditor, :price, :summary
end
