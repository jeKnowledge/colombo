class ForgotPassword < ApplicationRecord
  after_save :assign_token

  belongs_to :user

  private
    def assign_token
      self.update_columns(token: SecureRandom.urlsafe_base64.to_s)
    end
end
