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
    use BetterErrors::Middleware
    # need to set in order to abbreviate filenames
    BetterErrors.application_root = File.expand_path('..', __FILE__)
  end

  # start the server if ruby file executed directly
  run! if app_file == $PROGRAM_NAME

end

# include helpers and routes
require_relative 'helpers/init'
require_relative 'routes/init'
