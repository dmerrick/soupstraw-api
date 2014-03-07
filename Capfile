# load DSL and setup stages
require 'capistrano/setup'

# includes default deployment tasks
require 'capistrano/deploy'

# includes rvm support
require 'capistrano/rvm'

# includes bundler tasks
require 'capistrano/bundler'

# enable OSX notifications
require 'capistrano-nc/nc'

# enable datadog integration
require 'capistrano/datadog'

#TODO: implement this
# https://github.com/cramerdev/capistrano-chef
#require 'capistrano/chef'

# includes migration tasks
#TODO: get migrations working
#require 'capistrano/rails/migrations'

#TODO: maybe add this later?
#require 'new_relic/recipes'

# loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.cap').each { |r| import r }
