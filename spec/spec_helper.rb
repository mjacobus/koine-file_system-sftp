# frozen_string_literal: true

require 'bundler/setup'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
else
  require 'simplecov'
  SimpleCov.start do
    add_filter %r{^/spec/}
  end
end

require 'koine/filesystem/adapters/sftp'
require 'rspec'
require 'awesome_print'

FIXTURES_PATH = File.expand_path('fixtures', __dir__)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def only_key(key, collection)
  collection.map do |item|
    item[key]
  end
end

def map_files(key, files)
  files.map do |entry|
    [entry[:path], entry[key]]
  end.to_h
end
