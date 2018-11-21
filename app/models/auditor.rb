class Auditor < User
  mount_uploader :cv, CVUploader

  has_many :reports, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates_presence_of :rating, :qualifications, :cv, :address, :company

  scope :company_address_like, -> (query) {
    query = "%#{query}%"
    where("company ILIKE ? OR address ILIKE ?", query, query)
  }

  scope :company_like, -> (query) { where("company ILIKE ?", "%#{query}%")}

  scope :address_like, -> (query) { where("address ILIKE ?", "%#{query}%")}

  def prefix
    'a_'
  end

  def rating
    if ratings != 0
      return rating_sum / self.ratings
    else
      return "Not rated"
    end
  end

  def rate(rating)
    self.rating_sum += rating
    self.ratings += 1
    self.save
  end
end
