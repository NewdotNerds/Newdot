# Tong
Tong lucha por un internet con contenido de calidad para las personas.

## Dependencias

Para instrucciones especializadas según plataforma visita https://gorails.com/setup.

1. Instala Ruby 2.3.0 con Homebrew:
`brew install rbenv ruby-build`
`rbenv install 2.3.0`

2. Instala Rails:
`gem install rails -v 4.2.6`
`rbenv rehash`

3. Instala PostgreSQL:
`brew install postgresql`

4. Instala Elasticsearch:
`brew install elasticsearch`

5. Instala Redis:
`brew install redis`

No olvides correr PostgreSQL, Elasticsearch y Redis en el momento o como background services.

## Este repositorio

1. Clona Tong:
`git clone git@github.com:omartorresrios/Tong.git`

2. Installa todas las gemas:
`cd Tong`
`bundle install`

3. Ejecuta Sidekiq, Elasticsearch y Mailer:
`bundle exec sidekiq -q elasticsearch -q mailer -c 3`

4. Instala y migra la base de datos:
`rake db:setup`
`rake db:migrate`

5. Crea un index con Elasticsearch:
`rake elasticsearch:reindex`

6. Corre el servidor local:
`rails server`

Happy coding!
