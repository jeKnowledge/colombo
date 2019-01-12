class Client < NormalUser
  has_many :requests, dependent: :destroy
  has_many :purchases, dependent: :destroy
  has_many :reservations, dependent: :destroy

  def prefix
    'cus'
  end
end
