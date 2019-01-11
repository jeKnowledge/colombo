class UserMailer < ApplicationMailer
  def send_credentials(user, password)
    @username = user.username
    @password = password

    mail(to: user.email, subject: "Thanks for signing up on Colombo!")
  end
end
