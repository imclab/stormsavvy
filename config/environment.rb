# Load the rails application
require File.expand_path('../application', __FILE__)

# Load heroku vars from local file
heroku_env = File.join(Rails.root, 'config', 'heroku_env.rb')
load(heroku_env) if File.exists?(heroku_env)

# Initialize the rails application
Stormsavvy::Application.initialize!

# ActionMailer::Base.smtp_settings = {
#   :address              => "smtp.gmail.com",
#   :port                 => 587,
#   :domain               => 'stormsavvy.com',
#   :user_name            => ENV['STORMSAVVY_GMAIL_USERNAME'],
#   :password             => ENV['STORMSAVVY_GMAIL_PASSWORD'],
#   :authentication       => 'plain',
#   :enable_starttls_auto => true
# }

# Sendgrid smtp settings
# ActionMailer::Base.smtp_settings = {
#   :user_name 				=> ENV['SENDGRID_USERNAME'],
#   :password 				=> ENV['SENDGRID_PASSWORD'],
#   :domain 				=> "heroku.com",
#   :address 				=> "smtp.sendgrid.net",
#   :port 					=> 587,
#   :authentication 		=> :plain,
#   :enable_starttls_auto 	=> true
# }

# Disable until Redis required for weather/zipcode data
# IronWorker.configure do |config|
#   config.token      = ENV['IRONIO_TOKEN']
#   config.project_id = ENV['IRONIO_ID']
# end
