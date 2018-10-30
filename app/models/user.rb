class User < ApplicationRecord
  has_secure_password

  after_save :generate_username

  validates_presence_of :email

  attr_accessor :terms

  private

  def generate_username
    self.update_column(:username , "c_#{self.first_name[0..2]}#{self.last_name[0..2]}#{self.id}")
  end
end
