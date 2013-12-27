source 'http://rubygems.org'
ruby '2.0.0'

gem 'rake'
gem 'rails', '4.0.2'
# gem 'rails', '3.2.15'
gem 'typhoeus'
gem 'nokogiri'
gem 'geocoder'
gem 'devise'
gem 'pg'
gem 'redis'
gem 'json'
gem 'carmen'
gem 'activeadmin', github: 'gregbell/active_admin'

gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap-sass'
gem 'coffee-script-source'
gem 'sass-rails'
gem 'coffee-rails'
gem 'uglifier'

gem 'prawn', :git => 'git://github.com/WalterYu/prawn.git'
gem 'pdf-reader'
gem 'simple_form'
gem 'nested_form'

gem 'unicorn'
gem 'paperclip'
gem 'aws-sdk'
gem 'heroku'
gem 'unirest'

# Rails 4 upgrade gems
gem 'activeresource'
gem 'protected_attributes'
gem 'activerecord-deprecated_finders'
gem 'rails-observers'
# gem 'actionpack-page_caching'
# gem 'actionpack-action_caching'
# gem 'activerecord-session_store'
# gem 'rails-perftest'

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
  gem 'database_cleaner', '1.0.0.RC1'
  gem 'capybara'
  gem 'cucumber'
  gem 'sqlite3'
  gem 'spork-rails'
  gem 'autotest'

  gem 'email_spec' # comment out for bundle update
  gem 'awesome_print'
  gem 'pdf-inspector', :require => 'pdf/inspector'
  gem 'simplecov', :require => false
end

group :production do
  gem 'sentry-raven'
  gem 'newrelic_rpm'
end
