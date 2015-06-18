source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0.rc1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
gem 'jquery-turbolinks' # fix for jquery
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Bootstrap
gem 'bootstrap-sass', '3.3.3'

# Devise auth
gem 'devise', '3.4.1'

# Indeed
gem 'indeed-ruby', '0.0.1'

# Httpparty
gem 'httparty', '0.13.5'

group :development, :test do
  gem 'sqlite3', '1.3.10'
  gem 'byebug', '3.5.1'
  gem 'web-console', '2.0.0'
end

group :test do
  #gem 'minitest-rails'
  #gem "minitest-rails-capybara"
  gem 'minitest-reporters', '1.0.10'
  gem 'mini_backtrace',     '0.1.3'
  #gem 'capybara', '~> 2.0'
  gem 'libnotify',          '0.9.1'  # Notifications
  gem 'guard',              '2.11.1' # Guard to use libnotify properly
  gem 'guard-minitest',     '2.4.3'
  gem 'spring',             '1.2.0' # spring server
end

# Heroku gems
group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',        '4.8.3'
end
