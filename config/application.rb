require_relative 'boot'

require 'rails/all'
require 'rack'
require 'prometheus/client/rack/collector'
require 'prometheus/client/rack/exporter'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module App
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.autoload_paths << Rails.root.join('lib')

    config.middleware.use Prometheus::Client::Rack::Collector
    # Setting up a different path: config.middleware.use Prometheus::Client::Rack::Exporter, path: '/prom_metrics'
    config.middleware.use Prometheus::Client::Rack::Exporter

  end
end
