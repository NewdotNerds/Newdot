source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'puma', '~> 2.15'
gem 'pg', '~> 0.15'

#Auth

gem 'devise', '~> 3.5.3'
gem 'omniauth-facebook', '~> 3.0'
gem 'omniauth-twitter', '~> 1.2'
gem 'omniauth-google-oauth2', '~> 0.3.1'


gem 'localeapp', '~> 1.0', '>= 1.0.2'

# Fron-end
gem 'react-rails', '~> 1.6'
gem 'sass-rails', '~> 5.0'
gem 'font-awesome-sass', '~> 4.5'
gem 'uglifier', '>= 1.3.0'
gem 'autoprefixer-rails', '~> 6.3'
gem 'turbolinks', '~> 2.5'
gem 'figaro'
gem 'jquery-rails'
gem 'jquery-ui-rails', '~> 5.0'
gem 'jbuilder', '~> 2.0'
gem 'redis'
gem 'friendly_id', '~> 5.1'
gem 'bootstrap-sass', '~> 3.3'
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'impressionist'
gem "redcarpet"

# Load will_paginate before elasticsearch gems.
gem 'will_paginate', '~> 3.1'

# Elasticsearch
gem 'elasticsearch-model', '~> 0.1.8'
gem 'elasticsearch-rails', '~> 0.1.8'

# Background Job
gem 'sidekiq', '~> 4.0'
gem 'sinatra', require: false
gem 'slim'

gem 'sidetiq', '~> 0.7.0'

gem 'nokogiri', '~> 1.6'

# Image upload
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.5'
gem 'fog', '~> 1.37'
gem 'net-ssh'


group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.4.0'
  gem 'poltergeist', '~> 1.8'
  gem 'awesome_print', '~> 1.6'
  gem 'bundler-audit', '~> 0.5.0'
end

group :development do
  gem 'rails_best_practices', '~> 1.15'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'guard-rspec', require: false
  gem 'spring-commands-rspec', '~> 1.0'
  gem 'rack-mini-profiler', '~> 0.9.8', require: false
  gem 'annotate'
  gem 'bullet', '~> 5.0'
  gem 'quiet_assets', '~> 1.1'
  gem 'pry-rails', '~> 0.3.4'
end

group :test do
  gem 'capybara', '~> 2.5.0'
  gem 'database_cleaner', '~> 1.5'
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'faker', '~> 1.6.1'
  gem 'launchy', '~> 2.4.3'
  gem 'selenium-webdriver', '~> 2.48.1'
end

group :production do
  
  gem 'rails_12factor', '0.0.2'
  gem 'bonsai-elasticsearch-rails'
end


gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
