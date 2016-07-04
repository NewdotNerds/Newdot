class LikeNotificationJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_id)
    user = User.find_by(id: user_id)
    post = @post.user
    LikeMailer.like_notification(post).deliver_now if user
  end
end