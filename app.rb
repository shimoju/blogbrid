ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

class Blogbrid < Sinatra::Base
  get '/' do
    'Hello Blogbrid!'
  end
end
