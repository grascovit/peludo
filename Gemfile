# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'active_storage_validations', '~> 0.8.2'
gem 'aws-sdk-s3', '~> 1.46.0', require: false
gem 'bootsnap', '~> 1.4.4', require: false
gem 'bootstrap', '~> 4.3.1'
gem 'devise', '~> 4.7.1'
gem 'devise_token_auth', '~> 1.1.2'
gem 'draper', '~> 3.1.0'
gem 'figaro', '~> 1.1.1'
gem 'font-awesome-sass', '~> 5.9.0'
gem 'jquery-rails', '~> 4.3.5'
gem 'kaminari', '~> 1.1.1'
gem 'mini_magick', '~> 4.9.5'
gem 'omniauth', '~> 1.9.0'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 4.1.0'
gem 'rack-cors', '~> 1.0.3'
gem 'rails', '~> 5.2.3'
gem 'sass-rails', '~> 5.0.7'
gem 'sidekiq', '~> 5.2.7'
gem 'state_machines-activerecord', '~> 0.6.0'
gem 'uglifier', '~> 4.1.20'

group :development, :test do
  gem 'factory_bot_rails', '~> 5.0.2'
  gem 'pry', '~> 0.12.2'
  gem 'rspec-rails', '~> 3.8.2'
  gem 'rubocop', '~> 0.74.0', require: false
  gem 'rubocop-rspec', '~> 1.35.0'
end

group :development do
  gem 'letter_opener', '~> 1.7.0'
  gem 'listen', '~> 3.1.5'
  gem 'spring', '~> 2.1.0'
  gem 'spring-watcher-listen', '~> 2.0.1'
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'faker', '~> 2.1.2'
  gem 'json_matchers', '~> 0.11.1'
  gem 'shoulda-matchers', '~> 4.1.2'
  gem 'simplecov', '~> 0.17.0', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
