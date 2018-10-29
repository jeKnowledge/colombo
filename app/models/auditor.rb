class Auditor < ApplicationRecord
  mount_uploader :cv, CVUploader

  belongs_to :user

  validates_presence_of :email, :rating, :qualifications, :cv
  validates_uniqueness_of :email
end
