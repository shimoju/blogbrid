ENV['RACK_ENV'] ||= 'development'
require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

class Blogbrid < Sinatra::Base
  require_relative 'lib/blogbrid'

  configure do
    register Sinatra::ConfigFile
    config_file 'config.yml'
    set :theme_path, "themes/#{settings.theme}"
    set :views, "#{settings.root}/#{settings.theme_path}/views"
    set :content_path, "#{settings.root}/content"
    Page.base_path = "#{settings.content_path}/pages"
    Post.base_path = "#{settings.content_path}/posts"

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

  # Post
  get '/*/' do |path|
    post = Post.new(Post.url_to_filename(path))
    pass unless post.exist?
    slim :post, locals: { content: post, post: post }
  end

  # Page
  get '/*/' do |path|
    page = Page.new(Page.url_to_filename(path))
    pass unless page.exist?
    slim :page, locals: { content: page, page: page }
  end
end
