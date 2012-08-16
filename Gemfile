source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'pg', '0.14.0'

gem 'bootstrap-sass', '2.0.0'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1'
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'itunes-search-api'
gem 'spotify-metadata'
gem 'meta-spotify'
gem 'heroku'
gem 'multi_json', '1.0.3'
gem 'nestling', '0.1.2'
gem 'jquery-rails', '2.0.0'

gem 'whenever', :require => false

gem 'songkickr', :git => 'git://github.com/nigelpurves/songkickr'
# gem 'songkickr', :path => '~/documents/development/songkickr'


group :development do
  gem 'annotate', '~> 2.4.1.beta'
end

group :test, :development do
  gem 'rspec-rails', '2.10.0'
  gem 'guard-rspec', '0.5.5'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '1.4.0'
  # gem 'cucumber-rails', '1.2.1', require: false
  gem 'database_cleaner', '0.7.0'
  gem 'vcr'
  gem 'fakeweb'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.4'
  gem 'coffee-rails', '3.2.2'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platform => :ruby
  gem 'uglifier', '1.2.3'
end

group :deploy do
  gem 'capistrano'
  gem 'capistrano_rsync_with_remote_cache'
end

group :production do
  gem 'unicorn'
end
