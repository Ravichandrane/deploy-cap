namespace :local do

  desc 'Build the project'
  task :build do
    run_locally do
      execute :npm, :run, :build
    end
  end

  desc 'Commit the project'
  task :commit do
    run_locally do
      execute :git, 'add .'
      set :commit_message, ask('your commit message ?', 'Commit & deploy to the server')
      message = fetch(:commit_message)
      execute :git, "commit -m '#{message}'"
      execute :git, :push
    end
  end

  desc 'Post a message to slack'
  task :slack do
    run_locally do
      execute :curl, "-X POST --data-urlencode 'payload={\"channel\": \"#dev_channel\", \"text\": \"Votre attention testeurs humains !\nUne nouvelle version du site *Jaiye* est disponible:\n • *#{fetch(:env_name)}*: #{fetch(:server_name)}\", \"icon_emoji\": \":robot_face:\"}' https://hooks.slack.com/services/SLACK_KEY"
    end
  end

end
