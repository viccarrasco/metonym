# frozen_string_literal: true

module Gnews
  class Query
    attr_accessor :gnews_api_key
    attr_accessor :uri

    def initialize(key)
      @gnews_api_key = key
      @gnews = Gnews::GnewsRepository.new(key)
    end

    def search(args, format:)
      request('search', args: args, format: format)
    end

    def top_news(args, format:)
      request('top-news', args: args, format: format)
    end

    private

    def request(resource, args:, format:)
      validate_query_parameters(args, format)

      case resource
      when 'search'
        response = @gnews.search(query: args)
      when 'top-news'
        response = @gnews.top_news(query: args)
      when 'topics'
        response = @gnews.topics(query: args)
      end
    rescue StandardError => e
      response = { errors: e.to_s }
    ensure
      presenter = Gnews::GnewsResponsePresenter.new
      return presenter.generate_formatted_response(response, format)
    end

    def validate_query_parameters(args, format)
      v = Validate::GnewsQueryValidator.new(@gnews_api_key,
                                            args: args, format: format)
      raise v unless v
    end
  end
end
