source 'https://rubygems.org'
ruby '2.1.8'

gem 'dotenv-rails', '~> 0.9.0', groups: [:development, :test] # store environment variables in .env like SECRET_TOKEN=something

gem 'rails', '~> 3.2.22'
gem 'jquery-rails', '~> 3.1.3'
gem 'sass-rails',   '~> 3.2.4'
gem 'bcrypt-ruby', '~> 3.0.1'

gem 'bootstrap-sass', '~> 2.0.2' # twitter bootstrap framework
gem 'faker', '~> 1.0.1' # generate test data
gem 'will_paginate', '~> 3.0.3' # multiple pages for indexes
gem 'bootstrap-will_paginate', '0.0.7' # use bootstrap styling for paging
gem 'redcarpet', '~> 2.1.1' # markdown
gem 'paperclip', '3.0.3' # uploads
gem 'cocaine', '~> 0.3.0' # paperclip dependency
gem 'aws-sdk', '~> 1.3.4' # storage
gem 'acts-as-taggable-on', '~> 2.3.3' # tags (used for Game Category Types)
gem 'recaptcha', require: 'recaptcha/rails'
gem 'unicorn', '~> 4.8.3' # faster, multi-threaded server
gem 'friendly_id', '~> 4.0.1' # friendly urls
gem 'paper_trail', '~> 2.6.3' # track changes and allow undo
gem 'omniauth-facebook', '~> 1.5.1' # allow registration and login via Facebook

gem 'rest-client', '~> 1.8.0'

gem 'nokogiri', '~> 1.6.2'

group :development, :test do
	gem 'sqlite3'
	gem 'rspec-rails', '~> 2.9.0'
	gem 'capybara', '1.1.2'
	gem 'seed_dump'
end

group :assets do
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.2.3'
end

group :production do
	gem 'pg', '~> 0.18.0'
end
