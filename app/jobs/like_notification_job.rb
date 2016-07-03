class LikeNotificationJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_id)
    user = User.find_by(id: user_id)
    post = Post.find(params[:post_id])
    liker = @user
    LikeMailer.like_notification(liker, post).deliver_now if user
  end
end