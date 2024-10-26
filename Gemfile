source "https://rubygems.org"

ruby "3.3.1"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "redis"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

# custom gems
gem 'active_interaction', '~> 5.3'
gem 'i18n'
gem 'rack-cors'
gem 'devise'
gem 'devise-jwt'
gem 'jsonapi-serializer'
gem 'blueprinter'
gem 'oj'
gem 'sidekiq'
# end

group :development, :test do
  gem 'pry'
  gem 'pry-rails' 
  gem 'pry-byebug' 
  gem "debug", platforms: %i[ mri windows ]
  gem 'factory_bot_rails'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'rspec-rails'
end
