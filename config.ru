# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)

# Figure out the Rails environment, defaulting to production
ENV['RAILS_ENV'] ||= 'production'

run Stormsavvy::Application
