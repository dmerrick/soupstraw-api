set :stage, :production
set :branch, ENV['REF'] || 'master'

# this still needs to be rails even if we don't use rails
set :rails_env, 'production'

set :ssh_options, {
  keys: [ fetch(:ssh_key) ],
  forward_agent: true
}

server 'dmerrick-mini.local',
        user: 'dmerrick',
        roles: %w{ app web media_center }
