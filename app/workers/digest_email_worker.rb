class DigestEmailWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options :queue => :mailer

  recurrence { weekly.day(:wednesday) }


  def perform
    User.find_each do |user|
      DigestMailer.daily_email(user).deliver_now
    end
  end
end