# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Stormsavvy::Application.initialize!

IronWorker.configure do |config|
  config.token      = ENV['IRONIO_TOKEN']
  config.project_id = ENV['IRONIO_ID']
end