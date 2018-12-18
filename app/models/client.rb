class Client < User
  has_many :requests, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reservations, dependent: :destroy

  validates_presence_of :address, :company

  def prefix
    'cus'
  end
end
