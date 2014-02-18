Stormsavvy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false
  config.eager_load = false

  # Do not cache results in developerment per RoR guides: http://goo.gl/cg13
  config.cache_store = :null_store

  # Log error messages when you accidentally call methods on nil.
  # config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.serve_static_assets = true

  # Testing with production mailer settings
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = {
    :host => 'stormsavvy.com'
    }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # config.action_mailer.perform_deliveries = true
  # config.action_mailer.raise_delivery_errors = true
  # config.action_mailer.default :charset => "utf-8"

  # Loads yaml password configuration file in development
  APP_CONFIG = YAML.load_file(File.join(Rails.root, 'config', 'config.yml'))[Rails.env]
  config.action_mailer.smtp_settings = {
    user_name: APP_CONFIG['STORMSAVVY_GMAIL_USERNAME'],
    password: APP_CONFIG['STORMSAVVY_GMAIL_PASSWORD'],
    address: "smtp.gmail.com",
    port: 587,
    domain: 'stormsavvy.com',
    authentication: 'plain',
    enable_starttls_auto: true
  }
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      bucket: APP_CONFIG['AWS_BUCKET'],
      access_key_id: APP_CONFIG['AWS_ACCESS_KEY_ID'],
      secret_access_key: APP_CONFIG['AWS_SECRET_ACCESS_KEY']
    }
  }
  config.wunderground_apikey = IO.read('./config/wunderground_apikey.txt').chomp
end
