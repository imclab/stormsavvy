source 'http://rubygems.org'

gem 'rake'
gem 'rails'
gem 'typhoeus'
gem 'nokogiri'
gem 'geocoder'
gem 'devise'
gem 'pg'
gem 'redis'
gem 'json'
gem 'carmen'
gem 'activeadmin'
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
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber'
  gem 'sqlite3'
  gem 'spork-rails'

  # comment out when running bundle update
  gem 'email_spec'

  gem 'awesome_print'
  gem 'pdf-inspector', :require => "pdf/inspector"
  gem 'simplecov', :require => false
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'sentry-raven'
  # gem 'newrelic_rpm'
end
