require_relative 'app'

require 'sinatra/asset_pipeline/task'
Sinatra::AssetPipeline::Task.define! Blogbrid

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError
end
