#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'json'
require 'bundler'

# include all gems specified in the gemfile
Bundler.require(:default)
Bundler.require((ENV['RACK_ENV'] || 'development').to_sym)

# include everything in lib
Dir['./lib/**/*.rb'].each  { |file| require file }

class SoupstrawAPI < Sinatra::Base

  configure :development do

    # turn off http basic auth
    set :disable_http_auth, true

    use BetterErrors::Middleware
    # need to set in order to abbreviate filenames
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

  # ------------------------------------------------------------

  set :settings_file, 'config/application.yml'
  env = settings.environment.to_s

  # import settings from application.yml
  application_settings = {}
  YAML::load(File.open(settings.settings_file))[env].each do |key, value|
    application_settings[key.to_sym] = value
  end
  set :app, application_settings

  #TODO: use the latest gem version
  set :hue, PhilipsHue::Bridge.new('lightsapp', settings.app[:hue_address])

  # ------------------------------------------------------------

  register do
    # this redirects users to the log in page if they're not a user
    def auth(type)
      condition do
        unless send("is_#{type}?")
          # ask the user for credentials...
          headers['WWW-Authenticate'] = 'Basic realm="Restricted Area"'
          # ...or just serve them a 401
          halt 401, "Not authorized\n"
        end
      end
    end
  end

end

# include helpers and routes
require_relative 'helpers/init'
require_relative 'routes/init'
