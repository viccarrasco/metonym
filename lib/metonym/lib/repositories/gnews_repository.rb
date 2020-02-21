# frozen_string_literal: true

module Gnews
  class GnewsRepository
    def initialize(api_key)
      @gnews_api_key = api_key
      @uri = 'https://gnews.io/api/v3/'
    end

    def search(query:)
      request(query: query, resource: 'search')
    end

    def top_news(query:)
      request(query: query, resource: 'top-news')
    end

    def topic
      request(query: query, resource: 'topic')
    end

    private

    def request(query, resource:)
      uri = URI(@uri += resource)
      uri.query = URI.encode_www_form(prepare_arguments(query))
      Net::HTTP.get_response(uri)
    end

    def prepare_arguments(query)
      query['mindate'] = query.has_key?('mindate') ? query['mindate'].strftime('%y-%m-%d') : nil
      query['maxdate'] = query.has_key?('maxdate') ? query['maxdate'].strftime('%y-%m-%d') : nil
      query['token'] = @gnews_api_key
      query
    end
  end
end
