source 'https://rubygems.org'

gem 'rails', '4.1.0'
gem 'bootstrap-sass', '~> 3.1.1.1'
gem 'bcrypt-ruby', '3.1.2'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate'

gem 'cancan'
gem 'rolify'

gem 'object_identifier'

# in dev launch with unicorn -p 3000 -c ./config/unicorn.rb
gem 'unicorn'

gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'rr'
gem 'seed-fu'

gem 'activeadmin', github: 'gregbell/active_admin'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development do
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
end

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem 'sqlite3'
  gem 'factory_girl_rails', '4.2.1'
end

group :production do
  gem 'pg', '0.15.1'
  gem 'rails_12factor', '0.0.2'
end

group :test do
  gem 'selenium-webdriver', '2.35.1'
  gem 'capybara', '2.1.0'
  gem 'cucumber-rails', '1.4.0', require: false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'growl', '1.0.3'
end
