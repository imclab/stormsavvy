source 'http://rubygems.org'

gem 'rake'
gem 'rails'
gem 'typhoeus'
gem 'nokogiri'
# gem 'geocoder', :git => "git://github.com/doolin/geocoder.git"
gem 'geocoder' , :git => "git://github.com/alexreisner/geocoder"
gem 'devise'
gem 'pg'
gem 'redis'

gem 'json'

gem 'carmen'
gem 'activeadmin'
gem 'rb-readline'

gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap-sass', ">= 2.1.0.1"
gem 'coffee-script-source', '~> 1.4.0'

gem 'prawn', :git => "git://github.com/WalterYu/prawn.git"
gem 'pdf-reader'

gem 'simple_form'
gem 'nested_form'#, :git => "git://github.com/ryanb/nested_form.git"

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
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  # gem 'newrelic_rpm'
  gem 'sentry-raven'
end
