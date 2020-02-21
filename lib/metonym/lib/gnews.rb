# frozen_string_literal: true

module Gnews
  class Query
    attr_accessor :gnews_api_key
    attr_accessor :gnews_version
    attr_accessor :uri

    def initialize(key)
      @gnews = Gnews::GnewsRepository.new(key)
    end

    def search(args, format:)
      begin
        v = Validate::GnewsQueryValidator.new(args: args, format: format)
        raise v unless v

        response = @gnews.search(@gnews_api_key, query: args)
      rescue Exception => e
        response = { errors: e.to_s }
      ensure
        if response.is_a?(Hash) && response.has_key?('errors')
          return response
        else
          if format.nil? || format == 'json'
            return response.body
          elsif format == 'hash'
            return JSON.parse(response.body)
          end
        end
      end
    end
  end
end
