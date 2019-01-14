class Auditor < NormalUser
  # Properties
  @@DEFAULT_RATING = 0

  # Relationships
  has_many :reports, dependent: :destroy
  has_many :plans, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reservations, dependent: :destroy

  # Validations
  validates_presence_of :rating, :qualifications
  validates_presence_of :cv, on: :create

  # Uploaders
  mount_uploader :cv, CVUploader

  # Scopes
  scope :company_address_like, -> (query) { where("company ILIKE ? OR address ILIKE ?", "%#{query}%", "%#{query}%") }
  scope :company_like, -> (query) { where("company ILIKE ?", "%#{query}%")}
  scope :address_like, -> (query) { where("address ILIKE ?", "%#{query}%")}

  # Static methods
  def self.set_default_rating(rating)
    @@DEFAULT_RATING = rating
  end

  def self.get_default_rating
    @@DEFAULT_RATING
  end

  # Methods
  def prefix
    'aud'
  end

  def rating
    if ratings != 0
      return rating_sum / self.ratings
    else
      return Auditor::get_default_rating()
    end
  end

  def rate(rating)
    self.rating_sum += rating
    self.ratings += 1
    self.save
  end

  # Callbacks
  def notify_cv_update
    AdminNotification.create(body: "User #{self.name} uploaded a new CV")
  end
end
