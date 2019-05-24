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
            return request(args, format, uri, 'top-headlines')
        end

        def everything(args, format = 'json')
            uri = URI("#{@uri}/everything")
            return request(args, format, uri, 'everything')
        end

        def sources(args, format = 'json')
            uri = URI("#{@uri}/sources")
            return request(args, format, uri, 'sources')
        end

        private
        def request(args, format, uri, endpoint)
            begin
                v = Validate::NewsApiValidator.new
                raise "API Key is required"        if v.is_key_present?(@news_api_key)  == false
                raise "Invalid parameter sequence" if v.is_query_valid?(args, endpoint) == false
                raise "Invalid country sent"       if v.is_country_valid?(args)  == false
                raise "Invalid language sent"      if v.is_language_valid?(args) == false
                raise "Invalid date or dates sent" if v.is_date_valid?(args)     == false
                raise "Invalid format sent"        if v.is_format_valid?(format) == false
                
                args = prepare_arguments(args)

                uri.query = URI.encode_www_form(args)
                response = Net::HTTP.get_response(uri)                
            rescue Exception => e
                response = {"errors" => e.to_s}
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

        def prepare_arguments(args)
            args['apiKey'] = @news_api_key
            args['from'] = args.has_key?('from') ? args['from'].strftime("%FT%T%:z") : nil
            args['to']   = args.has_key?('to')   ? args['to'].strftime("%FT%T%:z") : nil
            args
        end
    end
end