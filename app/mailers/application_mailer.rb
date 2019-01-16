class ApplicationMailer < ActionMailer::Base
  default from: ENV['PLATFORM_EMAIL']
  layout 'mailer'
end
