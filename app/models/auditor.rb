class Auditor < ApplicationRecord
  mount_uploader :cv, CVUploader

  has_one :user

  validates_presence_of :email, :rating, :qualifications, :cv
  validates_uniqueness_of :email
end
