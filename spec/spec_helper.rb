# frozen_string_literal: true

require 'scheming'
require 'factory_bot'
require 'json-schema'
require 'pry'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'
  config.include FactoryBot::Syntax::Methods

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

require_relative 'support/custom_matchers'
