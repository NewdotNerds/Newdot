class LikeMailer < ActionMailer::Base
  default from: 'notifications@tongs.co'

  def like_notification(liker, post)
    @liker = liker
    @post = post
    @user = @post.user
    mail(to: @user.email, subject: 'Alguien comentó tu post')
  end
end