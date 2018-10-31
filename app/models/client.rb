class Client < User
  has_many :requests

  validates_presence_of :address, :company

  def prefix
    'c_'
  end
end
