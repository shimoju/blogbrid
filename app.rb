ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

class Blogbrid < Sinatra::Base
  configure do
    register Sinatra::ConfigFile
    config_file 'config.yml'
  end

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
  end

  get '/' do
    "Hello #{settings.title}!"
  end
end
