class UserMailer < ApplicationMailer
  add_template_helper(UsersHelper)
  add_template_helper(PostsHelper)

  def welcome_email(user)
    @user = user
    @topstories = Post.top_stories(3).published
    mail to: @user.email, subject: "Tongs"
  end
end
