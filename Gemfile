source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.3.7'

# ----------------- #
# - Rails Default - #
# ----------------- #

gem 'rails', '~> 5.2.2'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails', '~> 4.3', '>= 4.3.3'
gem 'jbuilder', '~> 2.5'
gem 'turbolinks', '~> 5'
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# ------------ #
# - Optimize - #
# ------------ #

# Boot large ruby/rails apps faster
gem 'bootsnap', '1.1.1'

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# ------------ #
# - Database - #
# ------------ #

gem 'mysql2', '0.4.6'
gem 'sqlite3'
gem 'bullet', '~> 5.9', group: :development

# --------- #
# - Tools - #
# --------- #

gem 'carrierwave', '~> 1.3', '>= 1.3.1'
gem 'devise', '~> 4.6', '>= 4.6.1'
gem 'hamlit', '~> 2.9', '>= 2.9.2'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
gem 'letter_opener', '~> 1.7'
gem 'mini_magick', '~> 4.9', '>= 4.9.2'
gem 'rails-cdn-helper', '1.0.0'

# ------------ #
# - BDD Test - #
# ------------ #

group :test do
  gem 'cucumber-rails', '1.6.0', require: false
  gem 'database_cleaner', '1.6.2'
  gem 'email_spec', '2.1.1'
  gem 'factory_girl_rails', '4.8.0'
  gem 'rspec-rails', '3.6.0'
  gem 'selenium-webdriver', '3.4.3'
end

# ------ #
# - UI - #
# ------ #

gem 'bootstrap-sass', '~> 3.4.1'
gem 'simple_form', '~> 4.1'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.4'

# --------- #
# - Debug - #
# --------- #

group :development, :test do
  gem 'pry', '0.11.3'
  gem 'pry-rails', '0.3.6'
  gem 'pry-remote', '0.1.8'
  gem 'awesome_print', '1.8.0', require: false
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end
