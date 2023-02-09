# config valid for current version and patch releases of Capistrano
lock "~> 3.17.1"

set :application, "express-nodejs-helloworld-app"
set :repo_url, "git@github.com:arunbeniwal008/express-node-js-hello-world-app.git"

#set :user, 'deploy'
# set :scm_passphrase, "password"
set :deploy_to, "/home/deploy/hello-world"
#set :use_sudo, false
#set :scm, :git
#server "172.31.39.42",  roles: [:app, :web, :db], :primary => true 



##############Arun#################
namespace :deploy do

  desc 'Copy upstart script'
  task :upstart do
    on roles(:app) do
      within release_path do
        sudo :chmod, '+x', "/home/deploy/hello-world/current/node-server-restart.sh"
      end
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app) do
      sudo :"/bin/bash /home/deploy/hello-world/current/node-server-restart.sh"
    end
  end

  desc 'Install node modules'
  task :install_node_modules do
    on roles(:app) do
      within release_path do
        execute :sudo, 'npm' , 'install', '-s'
      end
    end
  end


  after :updated, :install_node_modules
  after :updated, :upstart
  after :publishing, :restart

end

###########arun-end#############







# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/home/deploy/hello-world"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, "config/database.yml", 'config/master.key'

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "tmp/webpacker", "public/system", "vendor", "storage"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
