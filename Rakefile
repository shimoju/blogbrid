require_relative 'app'

require 'sinatra/asset_pipeline/task'
Sinatra::AssetPipeline::Task.define! Blogbrid

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end

desc 'Build your site'
task build: 'build:site'

namespace :build do
  build_path = File.expand_path(Blogbrid.build_dir, Blogbrid.root)
  public_path = Blogbrid.public_folder

  task site: [:public, :assets, :content]

  task :prepare do
    FileUtils.mkdir_p(build_path) unless Dir.exist?(build_path)
    Blogbrid.assets_path = File.join(build_path, 'assets')
  end

  desc 'Copy public directory to build directory'
  task public: :prepare do
    FileUtils.copy_entry(public_path, build_path)
  end

  desc 'Build assets'
  task assets: [:prepare, 'assets:precompile']

  desc 'Build content'
  task content: :prepare do
    require 'rack/test'
    rack = Rack::Test::Session.new(Blogbrid)

    urls = [
      '/',
      Blogbrid::Page.all.map(&:url),
      Blogbrid::Post.all.map(&:url),
    ].flatten

    urls.each do |url|
      response = rack.get(url)
      out = url.end_with?('/') ? url + 'index.html' : url
      out.sub!(%r{^/}, '')
      out_path = File.expand_path(out, build_path)
      out_dir = File.dirname(out_path)

      msg = "#{url} => #{out}: "

      if response.ok?
        FileUtils.mkdir_p(out_dir) unless Dir.exist?(out_dir)
        if File.exist?(out_path) && File.read(out_path) == response.body
          msg << 'Identical'
        else
          File.write(out_path, response.body)
          msg << 'Create'
        end
      else
        msg << "Error (#{response.status})"
        msg << "\n---\n#{response.body}\n---\n"
      end
      puts msg
    end
  end

  desc 'Clean build directory'
  task :clean do
    FileUtils.rm_rf(build_path)
  end
end
