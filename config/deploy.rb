# config valid only for current version of Capistrano
lock "3.7.1"

set :application, 'my_app_name'
set :repo_url, "git@example.com:me/my_repo.git"
set :use_sudo, true
set :branch, 'dev'
set :site_name, 'folder_name'
set :server_name, 'server_ip'
set :env_name, 'Staging'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/v1'

# Value for keep releases
set :keep_releases, 2

namespace :deploy do

    before :starting, :local do
        invoke "local:build"
        invoke "local:commit"
    end

    after :finished, :slack do
      invoke "nginx:config"
      invoke "local:slack"
    end

end