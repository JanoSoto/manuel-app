# config valid only for current version of Capistrano
lock "3.8.1"
set :stage, 'production'
set :application, "RailsBoilerplate"
set :repo_url, "git@bitbucket.org:oferusdev/rails-boilerplate.git"

# Default branch is :master
ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
#set :branch, :develop

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/html/RailsBoilerplate"

set :deploy_via, :copy

# Default value for :format is :airbrussh.
# set :format, :airbrussh
set :format, :pretty

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 3

#set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle')

set :passenger_environment_variables, { :path => '/usr/lib/ruby/vendor_ruby/phusion_passenger/bin:$PATH' }
set :passenger_restart_command, '/usr/lib/ruby/vendor_ruby/phusion_passenger/bin/passenger-config restart-app'

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/develop`
        puts "WARNING: HEAD is not the same as origin/develop"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root --password=oferusdev mysql"
        execute :bundle, 'install'
        execute :chmod, '777 '+release_path.join('tmp/cache/').to_s
        execute :chmod, '777 '+release_path.join('log/').to_s
        execute :rake, 'db:create RAILS_ENV=production'
        execute :rake, 'db:migrate RAILS_ENV=production'
        execute :rake, 'db:seed RAILS_ENV=production'
        execute :service, 'apache2 restart'
      end
    end
  end
  
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
  
  before :starting,     :check_revision
#  after  :finishing,    :compile_assets
#  after  :finishing,    :cleanup
  after  :finishing,    :restart
end
