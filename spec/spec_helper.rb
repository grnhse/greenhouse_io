require 'rubygems'
require 'bundler'
require 'webmock/rspec'
require 'vcr'
require 'greenhouse_io'

require 'coveralls'
Coveralls.wear!

RSpec.configure do |config|
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/cassettes'
  config.hook_into :webmock
end
