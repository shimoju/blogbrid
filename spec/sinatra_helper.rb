ENV['RACK_ENV'] = 'test'

require 'spec_helper'
require_relative '../app'

def app
  @app ||= Blogbrid
end

require 'capybara/rspec'
require 'capybara/poltergeist'
Capybara.app = app
Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
