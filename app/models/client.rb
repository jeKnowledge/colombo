class Client < User
  has_one :user

  validates_presence_of :address, :company
end
