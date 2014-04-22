# application options
set :application, 'soupstraw-api'
set :domain, 'soupstraw.com'
set :deploy_to, '/data/soupstraw-api'

# user options
set :user, 'dmerrick'
set :group, 'dmerrick'
set :runner, 'dmerrick'
set :use_sudo, false
set :ssh_key, File.join(ENV['HOME'], '.ssh', 'id_rsa')
# set :pty, true

# git options
set :scm, :git
set :repo_url, 'git@github.com:dmerrick/soupstraw-api.git'
#ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :git_shallow_clone, 1
set :deploy_via, :remote_cache

# symlink options
set :linked_files, %w{config/application.yml}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

# rvm options
set :rvm_type, :user
set :rvm_ruby_version, `cat .ruby-version`.chomp

# set to :debug if things are breaking
set :log_level, :info

# datadog integration
set :datadog_api_key, YAML::load(File.open('config/application.yml'))['development']['datadog_key']

# some defaults to keep around
# set :default_env, { path: "/opt/rbenv/bin:$PATH" }
# set :keep_releases, 5
# set :format, :pretty

namespace :deploy do

  desc 'Restart web server'
  task :restart do
    on roles(:web), in: :sequence, wait: 5 do
      #TODO: implement me (for deafguy)
      #execute 'sudo /etc/init.d/unicorn full-restart'
    end
  end

  task :remind_user_to_restart do
    on roles(:web), in: :sequence, wait: 5 do
      puts '* ' * 28
      puts "*  Don't forget to manually restart the API endpoint! *"
      puts '* ' * 28
    end
  end

  # restart on each deploy
  #after :publishing, :restart
  after :publishing, :remind_user_to_restart

  # clean up old releases
  after :finishing, 'deploy:cleanup'

end

desc 'Report uptime for all servers'
task :uptime do
  on roles(:all) do |host|
    info "Host #{host} (#{host.roles.to_a.join(', ')}):\t#{capture(:uptime)}"
  end
end