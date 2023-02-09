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
