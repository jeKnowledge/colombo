class NormalUser < User
  validates_presence_of :name, :address, :company
end