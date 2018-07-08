# Newdot
It was created to help you share the topics that you master and increase your professional value.

Developed with Ruby on Rails and ReactJS. Use PostgreSQL as a database.

Work with Elasticsearch, a search engine to find people, posts and topics.

It also uses Redis and Sidekiq for work queues (Elasticsearch, mailer and sidekiq indexes).


## Dependencies

For specialized instructions according to platform visit https://gorails.com/setup.

1. Install Ruby 2.3.0 with Homebrew:
`brew install rbenv ruby-build` and then `rbenv install 2.3.0`

2. Install Rails 4.2.6:
`gem install rails -v 4.2.6` and then `rbenv rehash`

3. Install PostgreSQL:
`brew install postgresql`

4. Install Elasticsearch:
`brew install elasticsearch`

5. Install Redis:
`brew install redis`

Don't forget to run PostgreSQL, Elasticsearch and Redis at the moment or as background services: `brew services start postgresql elasticsearch redis`

## This repository

1. CLone Newdot:
`git clone git@github.com:omartorresrios/Tongs.git`

2. Install al the gems:
`cd Tongs` y luego `bundle install`

3. Execute Sidekiq, Elasticsearch and Mailer:
`bundle exec sidekiq -q elasticsearch -q mailer -c 3`

4. Install and migrate db:
`rake db:setup` y luego `rake db:migrate`

5. Create an index with Elasticsearch:
`rake elasticsearch:reindex`

6. Run local server:
`rails server`

Happy coding!
