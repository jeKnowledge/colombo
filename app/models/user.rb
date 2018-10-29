class User < ApplicationRecord
  has_secure_password

  validates_presence_of :password_digest, :email
  validates_uniqueness_of :email

  attr_accessor :terms
end
