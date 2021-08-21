source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.2'

# -- Core -- #
# Full-stack web application framework. (https://rubyonrails.org)
gem 'rails', '~> 6.1.4'
# Library for building Telegram Bots with Rails integration (https://github.com/telegram-bot-rb/telegram-bot)
gem 'telegram-bot'

# -- Infrastructure & Storage -- #
# Pg is the Ruby interface to the {PostgreSQL RDBMS}[http://www.postgresql.org/] (https://github.com/ged/ruby-pg)
gem 'pg'
# Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications (https://puma.io)
gem 'puma', '~> 5.0'
# A Ruby client library for Redis (https://github.com/redis/redis-rb)
gem 'redis'
# Redis for Ruby on Rails (http://redis-store.org/redis-rails)
gem 'redis-rails'

# -- Attachments & Extensions -- #
gem 'aasm'
# Effortless multi-environment settings in Rails, Sinatra, Pandrino and others (https://github.com/rubyconfig/config)
gem 'config'
# Virtus types for Telegram Bot API (https://github.com/telegram-bot-rb/telegram-bot-types)
gem 'telegram-bot-types'

group :development, :test do
  # -- Console and Debugging -- #
  # Ruby fast debugger - base + CLI (https://github.com/deivid-rodriguez/byebug)
  gem 'byebug'
  # A runtime developer console and IRB alternative with powerful introspection capabilities. (http://pry.github.io)
  gem 'pry'
  # Fast debugging with Pry. (https://github.com/deivid-rodriguez/pry-byebug)
  gem 'pry-byebug'
  # Use Pry as your rails console (https://github.com/rweng/pry-rails)
  gem 'pry-rails'

  # -- Tests -- #
  # help to kill N+1 queries and unused eager loading. (https://github.com/flyerhzm/bullet)
  gem 'bullet'
  # factory_bot_rails provides integration between factory_bot and rails 5.0 or newer (https://github.com/thoughtbot/factory_bot_rails)
  gem 'factory_bot_rails'
  # Ffaker generates dummy data. (https://github.com/ffaker/ffaker)
  gem 'ffaker'
  # Run Test::Unit / RSpec / Cucumber / Spinach in parallel (https://github.com/grosser/parallel_tests)
  gem 'parallel_tests'
  # rspec-3.10.0 (http://github.com/rspec)
  gem 'rspec'
  # RSpec for Rails (https://github.com/rspec/rspec-rails)
  gem 'rspec-rails'

  # -- Annotations -- #
  # Annotates Rails Models, routes, fixtures, and others based on the database schema. (http://github.com/ctran/annotate_models)
  gem 'annotate'
  # Add comments to your Gemfile with each dependency's description. (https://github.com/ivantsepp/annotate_gem)
  gem 'annotate_gem'

  # -- Audit -- #
  # Security vulnerability scanner for Ruby on Rails. (https://brakemanscanner.org)
  gem 'brakeman'
  # Patch-level verification for Bundler (https://github.com/rubysec/bundler-audit#readme)
  gem 'bundler-audit'
end

group :development do
  # -- Linter -- #
  # Automatic Ruby code style checking tool. (https://github.com/rubocop/rubocop)
  gem 'rubocop', require: false
  # Automatic Rails code style checking tool. (https://github.com/rubocop/rubocop-rails)
  gem 'rubocop-rails', require: false
  # Code style checking for RSpec files (https://github.com/rubocop/rubocop-rspec)
  gem 'rubocop-rspec', require: false

  # -- Deploy -- #
  gem 'capistrano', require: false
  gem 'capistrano-passenger', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rbenv', require: false
end

group :test do
  # -- Test Supports -- #
  # Fake (In-memory) driver for redis-rb. (https://guilleiguaran.github.com/fakeredis)
  gem 'fakeredis'
  # Code coverage for Ruby (https://github.com/simplecov-ruby/simplecov)
  gem 'simplecov'
  # Ruby applications tests profiling tools (http://github.com/test-prof/test-prof)
  gem 'test-prof'
  # Library for stubbing HTTP requests in Ruby. (http://github.com/bblimke/webmock)
  gem 'webmock'
end
