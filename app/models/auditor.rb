class Auditor < NormalUser
  mount_uploader :cv, CVUploader

  has_many :reports, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates_presence_of :rating, :qualifications
  validates_presence_of :cv, on: :create

  scope :company_address_like, -> (query) {
    query = "%#{query}%"
    where("company ILIKE ? OR address ILIKE ?", query, query)
  }

  scope :company_like, -> (query) { where("company ILIKE ?", "%#{query}%")}

  scope :address_like, -> (query) { where("address ILIKE ?", "%#{query}%")}

  def prefix
    'aud'
  end

  def rating
    if ratings != 0
      return rating_sum / self.ratings
    else
      return Report::get_default_rating()
    end
  end

  def rate(rating)
    self.rating_sum += rating
    self.ratings += 1
    self.save
  end

  def notify_cv_update
    AdminNotification.create(body: "User #{self.name} uploaded a new CV")
  end
end
