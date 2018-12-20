class UserMailer < ApplicationMailer
  default from: ENV.fetch("GMAIL_EMAIL")

  def password_recovery(user, token)
    @user = user
    @token = token
    mail(to: "#{user.username} <#{user.email}>", subject: "Password Recovery")
  end
end
