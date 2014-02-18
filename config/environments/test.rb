Stormsavvy::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Path to Geocoder caching file path
  config.cache_store = :file_store, "#{Rails.root}/tmp/cache"

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  # config.whiny_nils = true
  config.eager_load = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection = false

  # Testing with production mailer settings
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.default_url_options = { host: 'stormsavvy.com' }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

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
  config.wunderground_apikey = IO.read('./config/wunderground_apikey.txt').chomp

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  # config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
end
