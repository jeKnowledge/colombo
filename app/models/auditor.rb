class Auditor < User
  mount_uploader :cv, CVUploader

  has_one :user
  has_many :reports
  has_many :plans

  validates_presence_of :rating, :qualifications, :cv, :address, :company

  scope :company_address_like, -> (query) {
    query = "%#{query}%"
    where("company LIKE ? OR address LIKE ?", query, query)
  }

  scope :company_like, -> (query) { where("company LIKE ?", "%#{query}%")}

  scope :address_like, -> (query) { where("address LIKE ?", "%#{query}%")}

  def prefix
    'a_'
  end

end
