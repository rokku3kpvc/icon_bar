require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_job/railtie'
require 'active_record/railtie'
require 'active_storage/engine'
require 'action_controller/railtie'
require 'action_view/railtie'

Bundler.require(*Rails.groups)

module IconBar
  class Application < Rails::Application
    config.load_defaults 6.1

    config.i18n.default_locale = :en
    config.i18n.fallbacks = true
    config.api_only = true
    # config.time_zone = 'Europe/Moscow'
    config.time_zone = 'Asia/Yekaterinburg'
    config.eager_load_paths += %w[lib]
    config.active_record.schema_format = :sql

    config.telegram_updates_controller.session_store = :redis_store, { expires_in: 1.month }
  end
end
