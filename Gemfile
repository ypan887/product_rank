source 'https://rubygems.org'

ruby "2.3.0"

gem 'rails', '4.2.5'
gem 'httparty'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'slim', '~> 3.0.6'
gem 'figaro'
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
gem 'redis-rack-cache'

group :development do
  gem 'guard-rspec'
end

group :test do
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'simplecov', :require => false
  gem 'coveralls', :require => false
  gem 'rb-fsevent'
  gem 'rspec-nc'
end

group :development, :test do
  gem 'pry-rails'
  gem 'spring'  
  gem 'pry'
  gem 'sqlite3'
end

group :production do
  gem 'pg'
end

group :assets do
  gem 'materialize-sass'
  gem 'sass-rails', '~> 5.0.4'
  gem 'compass-rails', '~> 2.0.4'
  gem 'jquery-rails'
  gem 'uglifier'
end

