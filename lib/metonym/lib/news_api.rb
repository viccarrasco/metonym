# frozen_string_literal: true

module NewsApi
  class Query
    attr_accessor :news_api_key
    attr_accessor :uri

    def initialize(key)
      @news_api_key = key
      @news_api = NewsApi::NewsApiRepository.new(key)
    end

    def everything(args, **options)
      request('everything', args: args, format: define_response_format(options))
    end

    def top_headlines(args, **options)
      request('top-headlines', args: args, format: define_response_format(options))
    end

    def sources(args, **options)
      request('sources', args: args, format: define_response_format(options))
    end

    private

    def define_response_format(options)
      options[:format] || 'json'
    end

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
