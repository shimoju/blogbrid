ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])
require_relative 'lib/blogbrid'

class Blogbrid < Sinatra::Base
  configure do
    register Sinatra::ConfigFile
    config_file 'config.yml'
    set :theme_path, "themes/#{settings.theme}"
    set :content_path, "#{settings.root}/content"
    set :posts_path, "#{settings.content_path}/_posts"
    set :views, "#{settings.root}/#{settings.theme_path}/views"

    set :assets_prefix, %W(assets vendor/assets #{settings.theme_path}/assets)
    set :assets_css_compressor, :sass
    set :assets_js_compressor, :uglifier
    set :assets_digest, false if settings.development?
    register Sinatra::AssetPipeline
    if defined?(RailsAssets)
      RailsAssets.load_paths.each { |path| settings.sprockets.append_path(path) }
    end
  end

  configure :development do
    require 'sinatra/reloader'
    register Sinatra::Reloader
    use Rack::LiveReload
    set :slim, pretty: true, sort_attrs: false
  end

  get '/' do
    slim :index
  end

  get '/:year/:month/:day/:name/' do
    path = "#{settings.posts_path}/#{params[:year]}-#{params[:month]}-#{params[:day]}-#{params[:name]}.md"
    pass unless File.exist?(path)
    post = Post.new(path)
    slim :post, locals: { content: post, post: post }
  end

  get '/*/' do |file|
    path = "#{settings.content_path}/#{file}.md"
    pass if file.start_with?('_') || !File.exist?(path)
    slim :content, locals: { content: Content.new(path) }
  end
end
