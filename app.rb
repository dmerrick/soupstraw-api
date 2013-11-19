#!/usr/bin/env ruby

require 'rubygems'
require 'open-uri'
require 'json'
require 'bundler'

# include all gems specified in the gemfile
Bundler.require(:default)
Bundler.require((ENV['RACK_ENV'] || 'development').to_sym)

# include everything in lib and everything in models
Dir['./lib/**/*.rb'].each  { |file| require file }
Dir['./helpers/*.rb'].each { |file| require file }

class SoupstrawAPI < Sinatra::Base

  get '/' do
    'hello, world'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
