class Purchase < ApplicationRecord
  belongs_to :report
  belongs_to :client
  belongs_to :auditor

  validates_presence_of :price

  def rate(rating)
    self.report.rate(rating)
    self.rating = rating
    self.save
  end
end
