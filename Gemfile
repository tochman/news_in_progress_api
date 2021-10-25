source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'

gem 'bootsnap', '>= 1.4.4', require: false
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', require: 'rack/cors'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'simplecov', require: false, group: :test
gem 'devise_token_auth'
gem 'pundit'
gem 'jbuilder'
gem 'active_model_serializers', '~> 0.10.12'

group :development, :test do
  gem 'factory_bot_rails'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'pundit-matchers', '~> 1.7.0'
  gem 'faker'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
end
