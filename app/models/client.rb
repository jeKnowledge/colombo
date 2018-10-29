class Client < User
  belongs_to :user

  validates_presence_of :address, :company
end
