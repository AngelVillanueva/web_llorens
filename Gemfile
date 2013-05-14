source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails', '3.2.13'
gem 'pg', '~> 0.15'
gem 'thin', '~> 1.5.1'
gem 'decent_exposure', '~> 2.1.0'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'jquery-rails', '~> 2.1'
gem 'simple_form', '~> 2.1' # add gem 'country_select' if needed
gem 'prawn_rails' # pdf creation
gem 'Ascii85', '~> 1.0.1' # or pdf-reader will fail
gem 'pdf-reader' # pdf reading
# Devise
gem 'devise', '~> 2.2.4'
# Rails_Admin
gem 'rails_admin', '~> 0.4.3'
# CanCan
gem 'cancan', '~> 1.6.1'

group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '~> 2.1.0'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.13.1'
  ### GUARD
  gem 'guard-rspec', '~> 2.3.0'
  gem 'guard-cucumber', '~> 1.2.2'
  gem 'growl', '1.0.3'
  gem 'rb-fsevent', '~> 0.9.1', require: false
end

group :development do
  gem 'annotate', '2.5.0'
  gem 'awesome_print', '1.1.0' # cool console object output
  gem 'better_errors', '0.8.0' # cool error info pages in development. Trace last error also by navigating to 0.0.0.0:3000/__better_errors
  gem 'binding_of_caller', '0.7.1' # cool error info pages in development
  gem 'meta_request', '0.2.1' # rails_panel chrome extension.
  gem 'sextant', '0.2.3' # Navigate to 0.0.0.0:3000/rails/routes to see routes in the browser
end

group :test do
  gem 'capybara', '~> 2.1.0'
  gem 'cucumber-rails', '1.3.1', require: false
  gem 'database_cleaner', '0.9.1'
  gem 'factory_girl_rails', '4.2.1'
  ### GUARD WITH ZEUS
  gem 'zeus', '~> 0.13.3' # this is not really needed, but fails if not present
end
