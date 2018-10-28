class Admin < ApplicationRecord
  has_one :user
  validates_uniqueness_of :email
end
