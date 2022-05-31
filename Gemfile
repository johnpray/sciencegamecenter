source 'https://rubygems.org'
ruby '2.7.6'

gem 'dotenv-rails', '~> 0.9.0', groups: [:development, :test] # store environment variables in .env like SECRET_TOKEN=something

gem 'rails', '~> 4.2.11'
gem 'protected_attributes'

gem 'bigdecimal', '1.4.2' # https://github.com/ruby/bigdecimal/issues/127

gem 'jquery-rails', '~> 3.1.3'
gem 'sass-rails',   '~> 4.0.5'
gem 'bcrypt', '~> 3.1.2' # https://stackoverflow.com/questions/21853579/rails-nomethoderror-undefined-method-cost-for-bcryptengineclass

gem 'bootstrap-sass', '2.0.2' # twitter bootstrap framework
gem 'faker', '~> 1.0.1' # generate test data
gem 'will_paginate', '~> 3.0.3' # multiple pages for indexes
gem 'bootstrap-will_paginate', '0.0.7' # use bootstrap styling for paging
gem 'redcarpet', '~> 3.5.1' # markdown
gem 'paperclip', '3.0.3' # uploads
gem 'cocaine', '~> 0.3.0' # paperclip dependency
gem 'aws-sdk', '~> 1.3.4' # storage
gem 'acts-as-taggable-on', '~> 4.0.0' # tags (used for Game Category Types)
gem 'recaptcha'
gem 'unicorn', '~> 4.8.3' # faster, multi-threaded server
gem 'friendly_id', '~> 5.4.2' # friendly urls
gem 'paper_trail', '~> 3.0.9' # track changes and allow undo

gem 'rest-client', '~> 1.8.0'

gem 'nokogiri', '~> 1.8.3'

gem 'pg', '~> 0.18.0'

gem 'test-unit', '~> 3.0'

group :development, :test do
	gem 'sqlite3'
	# gem 'rspec-rails', '~> 2.9.0'
	gem 'capybara', '1.1.2'
	gem 'seed_dump'
end

group :assets do
  gem 'uglifier', '>= 1.2.3'
end
