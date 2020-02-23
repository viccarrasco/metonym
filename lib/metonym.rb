# frozen_string_literal: true

require 'metonym/version'
require 'date'
require 'net/http'
require 'metonym/lib/gnews.rb'
require 'metonym/lib/presenters/base_response_presenter.rb'
require 'metonym/lib/presenters/gnews_response_presenter.rb'
require 'metonym/lib/presenters/news_api_response_presenter.rb'
require 'metonym/lib/repositories/base_repository.rb'
require 'metonym/lib/repositories/gnews_repository.rb'
require 'metonym/lib/repositories/news_api_repository.rb'
require 'metonym/lib/validators/base_validator.rb'
require 'metonym/lib/validators/gnews_query_validator.rb'
require 'metonym/lib/validators/news_api_query_validator.rb'
require 'metonym/lib/news_api.rb'
require 'byebug'
require 'json'

module Metonym
  class Error < StandardError; end
  # Your code goes here...
end
