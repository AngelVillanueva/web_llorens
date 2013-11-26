source 'https://rubygems.org'

### BASIC FOUNDATION
ruby '1.9.3'
gem 'rails', '3.2.13'
gem 'thin', '1.5.1'
gem 'pg', '~> 0.15'
gem 'strong_parameters', '~> 0.2.1'
gem 'decent_exposure', '~> 2.1.0'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'jquery-rails', '~> 2.1'
gem 'jquery-ui-rails', '~> 3.0.1'
gem 'simple_form', '~> 2.1' # add gem 'country_select' if needed
gem 'faker', '~> 1.1.2'
gem 'fast_seeder'
# Use unicorn as the app server
gem 'unicorn'
# Deploy with Capistrano
gem 'capistrano'
# Qeue with Delayed Job
gem 'delayed_job_active_record'
gem 'daemons' # for production / capistrano
### PDF MANAGEMENT
gem 'prawn', '~> 1.0.0rc2' # force prawn version
gem 'prawn_rails', '~> 0.0.11' # pdf creation
gem 'Ascii85', '~> 1.0.1' # or pdf-reader will fail
gem 'pdf-reader', '~> 1.3.3' # pdf reading
gem "rghost", '~> 0.9.3' # needed to skip the first page, prawn fails
gem 'paperclip', '~> 3.0' # file attachment
### USER & PERMISSIONS MANAGEMENT
# Devise
gem 'devise_security_extension', git: 'git://github.com/phatworx/devise_security_extension.git' # for password_expirable
gem 'devise', '~> 2.2.4'
 # for password_expirable
# Rails_Admin
gem 'rails_admin', '~> 0.4.3'
gem 'rich' # rich editor based on CKEdit
# CanCan
gem 'cancan', '~> 1.6.1'
### OTHER
gem 'jquery-datatables-rails', '1.11.2', git: 'git://github.com/rweng/jquery-datatables-rails.git' # DataTables

group :assets do
  gem 'sass-rails',   '~> 3.2'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '~> 2.1.0'
end

group :development do
  gem 'annotate', '2.5.0'
  gem 'awesome_print', '1.1.0' # cool console object output
  gem 'better_errors', '0.8.0' # cool error info pages in development. Trace last error also by navigating to 0.0.0.0:3000/__better_errors
  gem 'binding_of_caller', '0.7.1' # cool error info pages in development
  gem 'meta_request', '0.2.1' # rails_panel chrome extension.
  gem 'sextant', '0.2.3' # Navigate to 0.0.0.0:3000/rails/routes to see routes in the browser
  gem 'quiet_assets', '~> 1.0.2' # Get rid of loading assets info in development log
  gem 'ruby_gntp', '~> 0.3.4' # Growl with Bullet
  gem 'bullet', '~> 4.6.0' # Advise on n+1 queries
  gem 'lol_dba', '~> 1.5.0' # Advise on missing indexes
  #gem 'railroady' # SVG generator for models and associations
end

group :test do
  gem 'rspec-rails', '~> 2.13.1'
  gem 'shoulda-matchers', '~> 2.1.0'
  gem 'capybara', '~> 2.1.0'
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'cucumber-rails', '1.3.1', require: false
  gem 'database_cleaner', '0.9.1'
  gem 'factory_girl_rails', '4.2.1'
  gem 'email_spec'
  gem 'launchy', '~> 2.3.0' # method save_and_open_page for capybara
  ### GUARD
  gem 'guard-rspec', '~> 2.3.0'
  gem 'guard-cucumber', '~> 1.2.2'
  gem 'growl', '1.0.3'
  gem 'rb-fsevent', '~> 0.9.1', require: false
  ### GUARD WITH ZEUS
  gem 'zeus', '~> 0.13.3' # this is not really needed, but fails if not present
end
