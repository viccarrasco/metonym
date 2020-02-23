# frozen_string_literal: true

module NewsApi
  class Query
    attr_accessor :news_api_key
    attr_accessor :uri

    def initialize(key)
      @news_api_key = key
      @news_api = NewsApi::NewsApiRepository.new(key)
    end

    def everything(args, format:)
      request('everything', args: args, format: format)
    end

    def top_headlines(args, format:)
      request('top-headlines', args: args, format: format)
    end

    def sources(args, format:)
      request('sources', args: args, format: format)
    end

    private

    def request(resource, args:, format:)
      validate_query_parameters(args, format, resource)

      case resource
      when 'top-headlines'
        response = @news_api.top_headlines(query: args)
      when 'everything'
        response = @news_api.everything(query: args)
      when 'sources'
        response = @news_api.sources(query: args)
      end
    rescue StandardError => e
      response = { errors: e.to_s }
    ensure
      presenter = NewsApi::NewsApiResponsePresenter.new
      return presenter.generate_formatted_response(response, format)
    end

    def validate_query_parameters(args, format, resource)
      v = Validate::NewsApiQueryValidator.new(@news_api_key, args: args, format: format, endpoint: resource)
      raise v unless v
    end
  end
end
