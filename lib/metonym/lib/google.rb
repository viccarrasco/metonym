module Gnews
    class Query
        attr_accessor :gnews_api_key
        attr_accessor :gnews_version
        attr_accessor :uri

        def initialize(key, version = nil)
            @gnews_api_key = key
            @gnews_version = version.nil? ? 'v2' : version
            @uri = URI('https://gnews.io/api/v2/')
        end

        def search(args, format = 'json')
            begin
                v = Gnews::Validate.new
                raise "API Key is required"        if v.is_key_present?(@gnews_api_key) == false
                raise "Invalid parameter sequence" if v.is_query_valid?(args)    == false
                raise "Invalid country sent"       if v.is_country_valid?(args)  == false
                raise "Invalid language sent"      if v.is_language_valid?(args) == false
                raise "Invalid date or dates sent" if v.is_date_valid?(args)     == false

                args = prepare_arguments(args)
                @uri.query = URI.encode_www_form(args)
                response = Net::HTTP.get_response(@uri)
            rescue Exception => e
                response = {"errors" => e.to_s}
            ensure
                if response.is_a?(Hash) && response.has_key?('error')
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

        private
        def prepare_arguments(args)
            args['mindate'] = args.has_key?('mindate') ? args['mindate'].strftime("%y-%m-%d") : nil
            args['maxdate'] = args.has_key?('maxdate') ? args['maxdate'].strftime("%y-%m-%d") : nil
            args["token"] = @gnews_api_key
            args
        end
    end
end