if Rails.env == "development"
# # Authenticates using config/config.yml file
	ActionMailer::Base.smtp_settings = {
		:user_name            => APP_CONFIG['STORMSAVVY_GMAIL_USERNAME'],
	  :password             => APP_CONFIG['STORMSAVVY_GMAIL_PASSWORD'],
	  :address              => "smtp.gmail.com",
	  :port                 => 587,
	  :domain               => 'stormsavvy.com',
	  :authentication       => 'plain',
	  :enable_starttls_auto => true
	}
else
	ActionMailer::Base.smtp_settings = {
	  :user_name 						=> ENV['STORMSAVVY_GMAIL_USERNAME'],
	  :password 						=> ENV['STORMSAVVY_GMAIL_PASSWORD'],
	  :address              => "smtp.gmail.com",
	  :port                 => 587,
	  :domain               => 'stormsavvy.com',
	  :authentication       => 'plain',
	  :enable_starttls_auto => true
	}

	# ActionMailer::Base.smtp_settings = {
	#   :user_name 						=> ENV['SENDGRID_USERNAME'],
	#   :password 						=> ENV['SENDGRID_PASSWORD'],
	#   :domain 							=> "heroku.com",
	#   :address 							=> "smtp.sendgrid.net",
	#   :port 								=> 587,
	#   :authentication 			=> :plain,
	#   :enable_starttls_auto => true
	# }
end