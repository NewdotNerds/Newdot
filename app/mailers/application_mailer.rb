class ApplicationMailer < ActionMailer::Base
  default from: "notifications@newdot.us"
  layout 'mailer'
end
