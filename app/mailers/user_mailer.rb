class UserMailer < ApplicationMailer
  def send_credentials(user, password)
    @username = user.username
    @password = password

    contract = Contract.where(active: true).first.try(:generate_pdf)
    attachments['contract.pdf'] = File.read(contract) if contract
    mail(to: user.email, subject: "Thanks for signing up on Colombo!")
  end

  def password_recovery(user, token)
    @user = user
    @token = token
    mail(to: user.email, subject: "Forgot password?")
  end
end
