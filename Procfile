web: bundle exec puma -C config/puma.rb
bundle exec sidekiq -q elasticsearch -q mailer -c 3