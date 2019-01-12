class UserMailer < ApplicationMailer
  def send_credentials(user, password)
    @username = user.username
    @password = password

    mail(to: user.email, subject: "Thanks for signing up on Colombo!")
  end

  def password_recovery(user, token)
    @user = user
    @token = token
    mail(to: user.email, subject: "Forgot password?")
  end
end
