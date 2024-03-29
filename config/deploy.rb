# config valid for current version and patch releases of Capistrano
lock '~> 3.16.0'

set :application, 'icon_bar'
set :repo_url, 'git@github.com:rokku3kpvc/icon_bar.git'
set :deploy_to, "/home/deploy/#{fetch :application}"
set :keep_releases, 5
set :pty, true

append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'tmp/session_store', 'vendor/bundle', '.bundle', 'public/system', 'public/uploads'
append :linked_files, 'config/credentials/production.key', 'config/database.yml'

namespace :telegram_bot do
  desc 'Starts a bot poller'
  task :start_poller do
    on roles(:app) do
      execute("nohup sh -c 'cd #{release_path} && bundle exec rake telegram:bot:poller RAILS_ENV=production &' > /dev/null 2>&1")
    end
  end
end

# TODO: добиться нормального запуска поллера в фоне
# after 'deploy:symlink:release', 'telegram_bot:start_poller'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
