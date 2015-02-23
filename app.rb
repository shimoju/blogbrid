ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

class Blogbrid < Sinatra::Base
  configure do
    register Sinatra::ConfigFile
    config_file 'config.yml'
    set :theme_path, "themes/#{settings.theme}"
    set :views, "#{settings.root}/#{settings.theme_path}/views"
  end

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
    set :slim, pretty: true, sort_attrs: false
  end

  get '/' do
    slim :index
  end
end
