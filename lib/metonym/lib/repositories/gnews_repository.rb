# frozen_string_literal: true

module Gnews
  class GnewsRepository < BaseRepository
    def initialize(api_key)
      @gnews_api_key = api_key
      @uri = 'https://gnews.io/api/v3/'
    end

    def search(query:)
      request(@uri, query: query, resource: 'search')
    end

    def top_news(query:)
      request(@uri, query: query, resource: 'top-news')
    end

    def topic
      request(@uri, query: query, resource: 'topic')
    end

    private

    def prepare_arguments(query)
      query['mindate'] = query.key?(:mindate) ? query[:mindate].strftime('%y-%m-%d') : nil
      query['maxdate'] = query.key?(:maxdate) ? query[:maxdate].strftime('%y-%m-%d') : nil
      query['token'] = @gnews_api_key
      query
    end
  end
end
