class Audit < ApplicationRecord
  # Relationships
  belongs_to :auditor
  has_many :messages, dependent: :destroy

  # Validations
  validates_presence_of :products, :date, :auditor, :price, :summary

  # Scopes
  scope :validated, -> { where(validated: true)}
  scope :paginate, -> (page, per_page) { page(page).per(per_page) }
  scope :products_like, -> (query) { where("products ILIKE '%#{query}%'") }
end
