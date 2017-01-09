namespace :nginx do

  desc 'Create config file for nginx'
  task :config do
    on roles(:app) do
      erb = File.read "lib/capistrano/templates/nginx_config.erb"
      config_name = fetch(:site_name)
      config_file =  "/tmp/nginx_#{config_name}"
      upload! StringIO.new(ERB.new(erb).result(binding)), config_file
      execute :sudo, :mv, config_file, "/etc/nginx/sites-available/#{config_name}"
      execute :sudo, :ln, '-fs', "/etc/nginx/sites-available/#{config_name}", "/etc/nginx/sites-enabled/#{config_name}"
      execute :sudo, :service, :nginx, :restart
    end
  end

end
