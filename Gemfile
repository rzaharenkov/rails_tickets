source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'slim-rails', '~> 3.1', '>= 3.1.2'
gem 'thor', '= 0.19.1'

gem 'bootstrap-sass', '~> 3.3.6'
gem 'react-rails', '~> 1.10'
gem 'react-bootstrap-rails', '~> 0.30.2'
gem 'sugar-rails', '~> 1.4', '>= 1.4.1'

gem 'webpacker', '~> 2.0'

gem 'devise', '~> 4.2'
gem 'devise-bootstrap-views', '~> 0.0.10'
gem 'aasm', '~> 4.11', '>= 4.11.1'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5', '>= 3.5.2'
end

group :development do
  gem 'puma', '~> 3.0'
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate', '~> 2.7', '>= 2.7.1'
end

group :test do
  gem 'factory_girl_rails', '~> 4.8'
  gem 'forgery', '~> 0.6.0'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
