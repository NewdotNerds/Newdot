class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail to: @user.email, subject: "Bienvenido a Tong " + @user.username.split(" ").first
  end
end
