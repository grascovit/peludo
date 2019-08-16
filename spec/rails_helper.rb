# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'simplecov'
SimpleCov.start 'rails' do
  add_filter 'mailers'
end

require File.expand_path('../config/environment', __dir__)
require 'spec_helper'
require 'rspec/rails'

abort('The Rails environment is running in production mode!') if Rails.env.production?

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.include Devise::Test::IntegrationHelpers, type: :request
end
