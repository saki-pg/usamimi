source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'
gem 'rails', '~> 6.1.7'
gem 'rails-i18n', '~> 6.0'

gem 'puma', '~> 5.0'
gem 'sass-rails', '>= 6'
gem 'webpacker', '5.4.4'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.7'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'devise'
gem 'devise-i18n'
gem 'devise-i18n-views'
gem 'activeadmin'
gem 'listen', '>= 3.0.5', '< 3.2'

group :production do
  gem 'pg'
  gem 'dotenv-rails'
end

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rubocop', require: false
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'sqlite3', '~> 1.4'
end

group :development do
  gem 'web-console', '>= 4.1.0'
  gem 'rack-mini-profiler', '~> 2.0'
  gem 'spring'
  gem "rails-erd"
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers', '~> 4.0', require: false
  gem 'shoulda-matchers'
end

gem 'font-awesome-sass'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'rails-controller-testing'
gem 'bootstrap', '~> 5.1.0'
gem 'aws-sdk-s3', require: false
