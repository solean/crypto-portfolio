# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sinatra', '2.0.1'
gem 'roo', '~> 2.7.0'
gem 'sinatra-activerecord'
gem 'sinatra-flash'
gem 'sinatra-redirect-with-flash'

group :development do
  gem 'pg'
end

group :production do
  gem 'pg'
end
