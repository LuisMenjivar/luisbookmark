source 'https://rubygems.org'

group :production do 
  gem 'pg' #sqlite3 gem is not supported on Heroku.
  gem 'rails_12factor'
end
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
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

#gems used other than the gems automacally loaded with rails new
gem 'bootstrap-sass' 
gem "figaro"
gem "devise"
gem "pundit"
gem 'embedly', '~> 1.9.1'
gem "paperclip", "~> 4.2"
#installed aws-sdk version 1 and 2 
#"Version 2 of the aws-sdk gem is not backwards compatible."
#"This allows you to install version 1 and version 2 in the same application." 
# -> from http://ruby.awsblog.com/post/TxFKSK2QJE6RPZ/Upcoming-Stable-Release-of-AWS-SDK-for-Ruby-Version-2
gem 'aws-sdk', '~> 2'   
gem 'aws-sdk-v1'  
gem 'masonry-rails', '~> 0.2.4'   

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  #gems added other that the gems automatically loaded with rail new
  gem 'rspec-rails', '~> 3.1.0'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'email_spec'
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3' #gem was automatically loaded with rails new but was placed in the developmet group for deployment with Heroku
  gem "factory_girl_rails", "~> 4.0"
  gem 'faker'
  gem 'shoulda-matchers', require: false
end