class User < ApplicationRecord
  has_secure_password
  belongs_to :client, optional: true
  belongs_to :auditor, optional: true
  belongs_to :admin, optional: true

  validates_presence_of :username, :password_digest
  validates_uniqueness_of :username
end
