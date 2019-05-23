module NewsApi
    class Query
        attr_accessor :news_api_key
        attr_accessor :news_api_version
        attr_accessor :uri

        def initialize(key, version = nil)
            @news_api_key = key
            @news_api_version = version.nil? ? 'v2' : version
            @uri = URI("https://gnews.io/api/#{@news_api_version}/")
        end

        def top_headlines()
        end

        def everything()
        end

        def sources()
        end
    end
end