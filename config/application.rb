require_relative 'boot'

require 'rails'
# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'action_cable/engine'
# require "sprockets/railtie"
require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FuturewarsApi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.web_console.whitelisted_ips = '127.0.0.1' if config.respond_to?(:web_console)

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
    config.game = config_for(:game)

    config.to_prepare do
      Rails.configuration.event_store = RailsEventStore::Client.new
      Rails.configuration.event_store.subscribe_to_all_events(EventLogger.new(Rails.logger))
      Rails.configuration.event_store.subscribe(ExperienceTracker.new, to: [PlayerMoved])
      Rails.configuration.event_store.subscribe(PromotionsTracker.new, to: [PlayerGainedExperience])
    end
  end
end
