class User < ApplicationRecord
  has_secure_password
  belongs_to :client, optional: true
  belongs_to :auditor, optional: true
  belongs_to :admin, optional: true

  validates_presence_of :username, :password_digest
  validates_uniqueness_of :username

  def user_type_path
    if user.client_id.present?
      redirect_to users_path
    elsif user.auditor_id.present?
      redirect_to auditors_path
    elsif user.admin_id.present?
      redirect_to admin_path
    end
  end
end
