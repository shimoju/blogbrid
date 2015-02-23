ruby '2.2.0'
source 'https://rubygems.org'

gem 'sinatra', require: 'sinatra/base'
gem 'sinatra-contrib', require: 'sinatra/config_file'
gem 'sinatra-asset-pipeline', require: 'sinatra/asset_pipeline'
gem 'uglifier'

gem 'foreman', require: false
gem 'puma', require: false

gem 'slim'
gem 'redcarpet'

source 'https://rails-assets.org' do
  gem 'rails-assets-normalize.css'
end

group :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'rack-test'
end

group :development, :test do
  gem 'rspec'
end

group :development do
  gem 'rack-livereload'
  gem 'guard'
  gem 'terminal-notifier'
  gem 'terminal-notifier-guard'
  gem 'guard-livereload', require: false
  gem 'guard-pow', require: false
  gem 'guard-rspec', require: false
end
