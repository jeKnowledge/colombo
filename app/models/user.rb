class User < ApplicationRecord
  has_secure_password

  validates_presence_of :password_digest, :email
  validates_uniqueness_of :email

  attr_accessor :terms

  def user_type_path
    if user.type == "Client"
      redirect_to client_path
    elsif user.type == "Auditor"
      redirect_to auditor_path
    elsif user.type == "Admin"
      redirect_to admin_path
    end
  end
end
