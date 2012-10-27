ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'stormsavvy.com',
  :user_name            => APP_CONFIG['STORMSAVVY_GMAIL_USERNAME'],
  :password             => APP_CONFIG['STORMSAVVY_GMAIL_PASSWORD'],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}

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