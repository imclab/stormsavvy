source 'http://rubygems.org'
ruby '2.0.0'

gem 'rake'
gem 'rails', '3.2.14'
gem 'typhoeus'
gem 'nokogiri'
gem 'geocoder'
gem 'devise'
gem 'pg'
gem 'redis'
gem 'json'
gem 'carmen'
gem 'activeadmin', :github => "gregbell/active_admin"
gem 'rb-readline'

gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'coffee-script-source'

gem 'prawn', :git => "git://github.com/WalterYu/prawn.git"
gem 'pdf-reader'
gem 'simple_form'
gem 'nested_form'

gem 'unicorn'
gem 'paperclip'
gem 'aws-sdk'
gem 'heroku'

group :development do
  gem 'therubyracer', :platforms => :ruby, :require => 'v8'
  gem 'letter_opener'
  gem 'xray-rails'
end

group :test, :development do
  gem 'builder'
  gem 'rspec-rails'
  gem 'rspec'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '0.9.1'
  gem 'capybara'
  gem 'cucumber'
  gem 'sqlite3'
  gem 'spork-rails'

  gem 'email_spec' # comment out for bundle update
  gem 'awesome_print'
  gem 'pdf-inspector', :require => "pdf/inspector"
  gem 'simplecov', :require => false
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :production do
  gem 'sentry-raven'
  gem 'newrelic_rpm'
end
