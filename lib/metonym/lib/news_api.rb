# frozen_string_literal: true

module NewsApi
  class Query
    attr_accessor :news_api_key
    attr_accessor :news_api_version
    attr_accessor :uri

    def initialize(key, version = nil)
      @news_api_key = key
      @news_api_version = version.nil? ? 'v2' : version
      @uri = "https://newsapi.org/#{@news_api_version}"
    end

    def top_headlines(args, format = 'json')
      uri = URI("#{@uri}/top-headlines")
      request(args, format, uri, 'top-headlines')
    end

    def everything(args, format = 'json')
      uri = URI("#{@uri}/everything")
      request(args, format, uri, 'everything')
    end

    def sources(args, format = 'json')
      uri = URI("#{@uri}/sources")
      request(args, format, uri, 'sources')
    end

    private

    def request(args, format, uri, endpoint)
      begin
        v = Validate::NewsApiValidator.new
        raise 'API Key is required'        unless v.is_key_present?(@news_api_key)
        raise 'Invalid parameter sequence' unless v.is_query_valid?(args, endpoint)
        raise 'Invalid country sent'       unless v.is_country_valid?(args)
        raise 'Invalid language sent'      unless v.is_language_valid?(args)
        raise 'Invalid date or dates sent' unless v.is_date_valid?(args)
        raise 'Invalid format sent'        unless v.is_format_valid?(format)

        args = prepare_arguments(args)

        uri.query = URI.encode_www_form(args)
        response = Net::HTTP.get_response(uri)
      rescue Exception => e
        response = { 'errors' => e.to_s }
      ensure
        response if response.is_a?(Hash) && response.has_key?('errors')
        response.body if (format.nil? || format == 'json')
        JSON.parse(response.body) if format == 'hash'
      end
    end

    def prepare_arguments(args)
      args['apiKey'] = @news_api_key
      args['from'] = args.has_key?('from') ? args['from'].strftime('%FT%T%:z') : nil
      args['to']   = args.has_key?('to')   ? args['to'].strftime('%FT%T%:z') : nil
      args
    end
  end
end
