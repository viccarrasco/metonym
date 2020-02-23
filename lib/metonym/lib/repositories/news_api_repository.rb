# frozen_string_literal: true

module NewsApi
  class NewsApiRepository < BaseRepository
    def initialize(api_key)
      @news_api_key = api_key
      @uri = 'https://newsapi.org/v2/'
    end

    def everything(query:)
      request(@uri, query: query, resource: 'everything')
    end

    def top_headlines(query:)
      request(@uri, query: query, resource: 'top-headlines')
    end

    def sources(query:)
      request(@uri, query: query, resource: 'sources')
    end

    private

    def prepare_arguments(query)
      query['from'] = query.key?(:from) ? query[:from].strftime('%FT%T%:z') : nil
      query['to']   = query.key?(:to)   ? query[:to].strftime('%FT%T%:z') : nil
      query['apiKey'] = @news_api_key
      query
    end
  end
end
