class Auditor < User
  mount_uploader :cv, CVUploader

  has_one :user

  validates_presence_of :rating, :qualifications, :cv
end
