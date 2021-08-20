ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start(:rails)

require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'webmock/rspec'
require 'rspec/rails'
require 'fakeredis/rspec'
require 'telegram/bot/rspec/integration/rails'
require 'telegram/bot/updates_controller/rspec_helpers'

WebMock.disable_net_connect!

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared_contexts/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.order = :random
  config.fixture_path = Rails.root.join('spec/fixtures')
  config.use_transactional_fixtures = true
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.render_views
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.full_backtrace = true

  config.include ActiveSupport::Testing::TimeHelpers
  config.include FactoryBot::Syntax::Methods

  Kernel.srand config.seed

  config.after { Telegram.bot.reset }
end
