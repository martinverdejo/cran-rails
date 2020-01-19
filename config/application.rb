require_relative 'boot'

require 'rails/all'
require 'sidekiq'
require 'sidekiq-cron'
require 'sidekiq/web'
require 'sidekiq/cron/web'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CranRails
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

Sidekiq.configure_server do |config|
  Sidekiq::Cron::Job.load_from_hash YAML.load_file("config/schedule.yml") if Sidekiq.server?
end
