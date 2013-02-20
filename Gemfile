source 'http://rubygems.org'

gem 'rake'
gem 'rails'
gem 'typhoeus'
gem 'nokogiri'
gem 'geocoder', :git => "git://github.com/doolin/geocoder.git" # :github => 'doolin/geocoder'
gem 'devise'
gem 'pg'
gem 'redis'

gem 'carmen'
gem 'activeadmin'
gem 'rb-readline'

gem 'haml-rails'
gem 'jquery-rails'
gem 'bootstrap-sass', ">= 2.1.0.1"

gem 'prawn', :git => "git://github.com/WalterYu/prawn.git"
gem 'pdf-reader'

gem 'simple_form'
gem 'nested_form'#, :git => "git://github.com/ryanb/nested_form.git"

# gem 'newrelic_rpm'
gem 'unicorn'

gem 'paperclip'
gem 'aws-sdk'

group :development do
  gem 'therubyracer', :platforms => :ruby, :require => 'v8'
  gem 'letter_opener'
end

group :test, :development do
#   gem 'travis'
  gem 'builder'

  gem 'rspec-rails', "2.12.0"
  gem 'rspec', "2.12.0"
  gem 'factory_girl_rails'
  gem 'cucumber-rails',"1.3.0", :require => false
  gem 'database_cleaner'
  gem 'capybara'
  gem 'cucumber', "1.2.1"
  gem 'sqlite3'
  gem 'spork-rails'

#   gem 'pry'
#   gem 'pry-remote'
#   gem 'pry-nav'

  gem 'awesome_print'
  gem 'pdf-inspector', :require => "pdf/inspector"
  gem 'simplecov', :require => false

#   gem 'ZenTest'
#   gem 'autotest-growl'
#   gem 'autotest-fsevent'

  # Comment out when running bundle update
  gem 'email_spec', "1.4.0"
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
