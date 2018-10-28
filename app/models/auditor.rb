class Auditor < ApplicationRecord
  has_one :user

  validates_presence_of :email, :rating, :qualifications, :cv
  validates_uniqueness_of :email

  after_new :generate_username

  def generate_username
    self.username = "a_#{self.first_name[0..2].downcase}#{self.last_name[0..2].downcase}_#{self.id}"
  end
end
