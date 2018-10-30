class User < ApplicationRecord
  attr_accessor :terms

  has_secure_password

  after_save :generate_username

  validates_presence_of :email

  def prefix
    ''
  end

  def generate_username
    self.update_column(:username , "#{self.prefix}#{self.first_name[0..2]}#{self.last_name[0..2]}#{self.id}")
  end
end
