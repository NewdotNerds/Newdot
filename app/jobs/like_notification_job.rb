class LikeNotificationJob < ActiveJob::Base
  queue_as :mailer

  def perform(user_id)
    user = User.find_by(id: user_id)
    liker = current_user
    post = @post
    LikeMailer.like_notification(liker, post).deliver_now if user
  end
end