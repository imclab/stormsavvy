ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'stormsavvy.com',
  :user_name            => 'alerts',
  :password             => ENV["STORMSAVVY_EMAIL_PASSWORD"],
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
