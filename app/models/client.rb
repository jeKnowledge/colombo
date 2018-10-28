class Client < ApplicationRecord
  has_one :user

  validates_presence_of :email, :address, :company
  validates_uniqueness_of :email
end
