source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgreSQL as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Framework front-end bootstrap
gem 'bootstrap-sass'
# Iconos svg 
gem 'font-awesome-sass'

source 'https://rails-assets.org/' do
	# Framework front-end basado en Bootstrap 
  gem 'rails-assets-adminlte'
end

# Autenticación de usuarios
gem 'devise'
gem 'devise-i18n'
# Paginación con estilo de boostrap
gem 'will_paginate-bootstrap'
# Cargado de pagina con estilo de pace
gem 'pace-rails'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Registro de cambios en los modelos (fuente: https://github.com/airblade/paper_trail)
gem 'paper_trail'

#Gema para las notificaciones tipo toast
gem 'toastr-rails'

#Gema para administrar las autorizaciones de acción
gem 'cancancan', '~> 2.0'

group :development, :test do
  # Capistrano para despliegue de aplicación en servidor remoto
  gem 'capistrano', '~> 3.0'
  gem 'capistrano-bundler', '1.1.1'
  gem 'capistrano-rails', '1.1.3'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  
  # Variables de entorno en development
  gem 'dotenv-rails'

  # Testing
  gem 'rspec-rails', '~> 3.5'

  # Análisis estático para detección de vulnerabilidades de seguridad (fuente: https://github.com/presidentbeef/brakeman)
  gem 'brakeman', require: false

  # Análisis estático de código para pautas de estilo de código (fuente: https://github.com/bbatsov/rubocop)
  gem 'rubocop', require: false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  ## Mejores erroes en develop
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
end

