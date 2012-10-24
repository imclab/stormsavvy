ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'stormsavvy.com',
  :user_name            => ENV["STORMSAVVY_GMAIL_USERNAME"],
  :password             => ENV["STORMSAVVY_GMAIL_PASSWORD"],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
