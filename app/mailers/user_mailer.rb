class UserMailer < ApplicationMailer
  def welcome_email(user)
    @user = user
    mail to: @user.email, subject: "Bienvenido a Tongs " + @user.username.split(" ").first
  end
end
