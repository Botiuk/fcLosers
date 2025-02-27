# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '7.2.2'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '1.1.0'

# Use postgresql as the database for Active Record
gem 'pg', '1.5.9'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '6.6.0'

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem 'jsbundling-rails', '1.3.1'

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem 'cssbundling-rails', '1.4.2'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '2.0.11'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '1.3.4'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '1.2024.2', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.18.4', require: false

# A set of common locale data and translations to internationalize and/or localize your Rails applications
gem 'rails-i18n', '7.0.9'

# Flexible authentication solution for Rails with Warden
gem 'devise', '4.9.4'
# Translations for the devise gem
gem 'devise-i18n', '1.12.1'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '1.14.0'
# Client library for easily using the Cloudinary service
gem 'cloudinary', '2.3.0'

# Agnostic pagination in plain ruby
gem 'pagy', '9.3.3'

# A simple Rails calendar
gem 'simple_calendar', '3.1.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '1.10.0', platforms: %i[mri windows], require: 'debug/prelude'

  # Testing framework
  gem 'rspec-rails', '7.1.1'
  # Fixtures replacement with a straightforward definition syntax
  gem 'factory_bot_rails', '6.4.4'
  # Library for generating fake data
  gem 'faker', '3.5.1'
end

group :development do
  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem 'brakeman', '7.0.0', require: false

  # RuboCop is a Ruby code style checking and code formatting tool.
  gem 'rubocop', '1.73.1', require: false
  # Automatic Rails code style checking tool.
  gem 'rubocop-rails', '2.30.2', require: false
  # A collection of RuboCop cops to check for performance optimizations in Ruby code.
  gem 'rubocop-performance', '1.24.0', require: false
  # Code style checking for RSpec files
  gem 'rubocop-rspec', '3.5.0', require: false
  gem 'rubocop-rspec_rails', '2.30.0', require: false
  # Code style checking for factory_bot files
  gem 'rubocop-factory_bot', '2.26.1', require: false
end
