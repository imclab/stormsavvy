require 'devise'
require 'prawn'
require 'nokogiri'
require 'pdf/reader'
require 'pdf/inspector'
require 'email_spec'
require 'capybara/rspec'
require 'rack/test'
require 'spork'
require 'sidekiq'
require 'sidekiq/testing'

include Warden::Test::Helpers
Warden.test_mode!
Warden.test_reset!

Spork.prefork do
end

Spork.each_run do
end

Prawn.debug = true

def create_pdf(klass=Prawn::Document)
  @pdf = klass.new(:margin => 0)
end

# Make some methods public to assist in testing
module Prawn::Graphics
  public :map_to_absolute
end

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

module ::RSpec::Core
  class ExampleGroup
    include Capybara::DSL
    include Capybara::RSpecMatchers
  end
end

RSpec.configure do |config|

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)

  config.include Devise::TestHelpers, :type => :controller
  config.include Devise::TestHelpers, :type => :view

  # config.include Rack::Test::Methods
  config.extend ControllerMacros, :type => :controllers

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  # config.infer_base_class_for_anonymous_controllers = false

  config.include Rails.application.routes.url_helpers

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end
end

RSpec::Matchers.define :have_xml do |xpath, text|
  match do |body|
    doc = Nokogiri::XML::Document.parse(body)
    nodes = doc.xpath(xpath)
    nodes.empty?.should be_false
    if text
      nodes.each do |node|
        node.content.should == text
      end
    end
    true
  end

  failure_message_for_should do |body|
    "expected to find xml tag #{xpath} in:\n#{body}"
  end

  failure_message_for_should_not do |response|
    "expected not to find xml tag #{xpath} in:\n#{body}"
  end

  description do
    "have xml tag #{xpath}"
  end
end
