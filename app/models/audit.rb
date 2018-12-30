class Audit < ApplicationRecord
  DEFAULT_RATING = 0

  # Relationships
  belongs_to :auditor
  has_many :messages, dependent: :destroy

  # Callbacks
  before_create :set_rating

  # Validations
  validates_presence_of :products, :date, :auditor, :price, :summary

  # Scopes
  scope :validated, -> { where(validated: true)}
  scope :paginate, -> (page, per_page) { page(page).per(per_page) }
  scope :products_like, -> (query) { where("products ILIKE '%#{query}%'") }

  # Methods
  def self.set_default_rating(rating)
    Audit::DEFAULT_RATING = rating
  end

  # Callback methods
  def set_rating
    self.rating = Auditor::DEFAULT_RATING
  end
end
