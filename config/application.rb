require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Rails 4 config update: 
# http://railscasts.com/episodes/415-upgrading-to-rails-4?view=asciicast
Bundler.require(:default, Rails.env)

=begin
if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end
=end

module Stormsavvy
  class Application < Rails::Application

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib/*)
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.enabled = true
    # config.assets.version = '1.0'
    config.assets.initialize_on_precompile = false
    config.active_record.whitelist_attributes = false
    config.i18n.enforce_available_locales = true

    config.to_prepare do
      DeviseController.respond_to :html, :json
    end
  end
end
