# Metonym

[![Build Status](https://travis-ci.org/viccarrasco/metonym.svg?branch=master)](https://travis-ci.org/viccarrasco/metonym)

A ruby gem for [GNews API](https://gnews.io) and [NewsApi](https://newsapi.org/)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metonym'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metonym

[Please read here!]()

## Typical Usage

To be able to send requests to the GNews API, you first must create an account to receive a token [here](https://gnews.io/register.php).

To be able to send requests to NewsApi, you first must create an account to receive a token [here](https://newsapi.org/).

## COVID-19

```ruby
# Establish parameters for query
args = { q: 'Covid-19', country: 'DE', mindate: (DateTime.now - 2), max: 1 }

# Send Request
gnews = Gnews::Query.new('my-secret-key')
response = gnews.search(args)

puts response

# =>

```

```json
{
  "status": "ok",
  "totalResults": 1,
  "articles": [
    {
      "source": {
        "id": "die-zeit",
        "name": "Die Zeit"
      },
      "author": "Bettina Schulz",
      "title": "Covid-19: Massenisolation statt HerdenimmunitxC3xA4t - ZEIT ONLINE",
      "description": "Die britische Regierung gibt ihre Strategie im Kampf gegen Covid-19 auf. Statt eine Erkrankung von Millionen Menschen in Kauf zu nehmen, setzt sie nun auf Isolation.",
      "url": "https://www.zeit.de/politik/ausland/2020-03/covid-19-grossbritannien-herdenimmunitaet-virusbekaempfung",
      "urlToImage": "https://img.zeit.de/politik/ausland/2020-03/covid-19-grossbritannien-herdenimmunitaet-virusbekaempfung-london/wide__1300x731",
      "publishedAt": "2020-03-15T19:39:58Z",
      "content": "InhaltrnAuf einer Seite lesenrn Inhaltrn<ol><li>Seite 1Massenisolation statt HerdenimmunitxC3xA4trn</li><li>Seite 2Das britische Gesundheitssystem ist fxC3xBCr ErnstfxC3xA4lle nicht gerxC3xBCstet</li></ol>rnNach deutlicher Kritik aus wissenschaftlichen Kreisen hat die britische xE2x80xA6 [+3845 chars]"
    }
  ]
}
```

## Query Gnews API

```ruby
# Establish parameters for query
args = { q: 'Dragon Ball Super', country: 'MX', mindate: (DateTime.now - 2), max: 1 }

# Send Request
gnews = Gnews::Query.new('my-secret-key')
response = gnews.search(args)

puts response

# =>
```

```json
{
  "timestamp": 1558081205,
  "count_results": 1,
  "articles": [
    {
      "title": "'Dragon Ball Super' Chapter 48 Release Date, Predictions: Moro Not the Real Villain, Truth Revealed?",
      "desc": "It has been quite a long wait, but it wou ld appear that Dragon Ball Super Chapter 48 will be coming out soon. Along with it is rumored to be a huge bombshell ...",
      "link": "https://www.econotimes.com/Dragon-Ball-Super-Chapter-48-Release-Date-Predictions-Moro-Not-the-Real-Villain-Truth-Revealed-1538175",
      "website": "https://www.econotimes.com",
      "source": "EconoTimes",
      "date": "Fri, 17 May 2019 05:43:46 GMT",
      "image": "https://lh4.googleusercontent.com/proxy/CDTeHID-9i5aNWFXTOImYAOOBAFyv8R_QewR4cwP38bycKmVpNS8W-dawVxxumt8FhuzPjXhql8c1y36tkmTaEBW5bCUhryqWH-RBtLnScf_-X8QNL-899A9Sxh2BRpN4Pkp=-c"
    }
  ]
}
```

You can also send a second parmeter to the search method to indicate that the response be parsed to a ruby hash for easier manipulation. By default, the request will respond with a JSON.

```ruby
# Establish parameters for query
args = { q: 'Game of Thrones', country: 'DE', max: 1 }

# Send Request with HASH response property
gnews = Gnews::Query.new('my-secret-key')
response = gnews.search(args, format: 'hash')

puts response
# =>

{
   "timestamp"=>1558094332,
   "count_results"=>1,
   "articles"=>[
      {
         "title"=>"'Game of Thrones' finale: How will it end? Here are a few theories",
         "desc"=>"", "link"=>"https://www.goodmorningamerica.com/culture/story/game-thrones-finale-popular-theories-end-63057785",
         "website"=>"https://www.goodmorningamerica.com",
         "source"=>"GMA",
         "date"=>"Fri, 17 May 2019 08:06:11 GMT",
         "image"=>"https://lh4.googleusercontent.com/proxy/KI8XVNS35Y9hvR55LjjCwpjB4zTUcQxQb5N3H41bc4JRvdcz5qZCIDG2bFHyO6WxqhdVQ5qc5TxPsoqaObiZsY9sqjZRvrsQ7qEdLewSS272opiVWH5S
MydvTAug0D-dSSDfZDG9oywTEcfQXsWXtzBHULFJzLYwJDjmnxza=-c"
      }
   ]
}



```

## Search Parameters

| Parameter | Info                                     | Description                                                                                   |
| --------- | ---------------------------------------- | --------------------------------------------------------------------------------------------- |
| q         | Required                                 | Your search                                                                                   |
| max       | Optional (default value : 10)            | The number of items you want (max possible : 100)                                             |
| lang      | Optional (default value : english)       | The article language ([list of all languages](https://gnews.io/documentation.php#NationList)) |
| country   | Optional (default value : United-States) | The article origin ([list of all countries](https://gnews.io/documentation.php#NationList))   |
| mindate   | Optional (Date/DateTime)                 | Get articles that are more recent than the min date                                           |
| maxdate   | Optional (Date/DateTime)                 | Get articles that are less recent than the max date                                           |
| in        | Optional                                 | Get articles that contains q in the specified article section                                 |

## Query NewsApi

### Top Headlines

Source: [NewsApi documentation.](https://www.newsapi.org/docs/endpoints)

> Returns breaking news headlines for a country and category, or currently running on a single or multiple sources. This is perfect for use with news tickers or anywhere you want to display live up-to-date news headlines and images.

```ruby
args = { q: 'Brexit', country: 'DE' }

news = NewsApi::Query.new('my-secret-key')

response = news.top_headlines(args)

# =>
```

```json
{
  "status": "ok",
  "totalResults": 1,
  "articles": [
    {
      "source": {
        "id": null,
        "name": "Faz.net"
      },
      "author": "Klaus-Dieter Frankenberger",
      "title": "Brexit-Opfer - FAZ - Frankfurter Allgemeine Zeitung",
      "description": "Das Brexit-Thema wurde May wie zuvor schon Cameron zum politischen Verhängnis  – und es ist eine Last, die auch die kommende Regierung nicht einfach abschütteln kann. Die EU allerdings auch nicht.",
      "url": "https://www.faz.net/aktuell/brexit/theresa-may-ist-wie-david-cameron-zum-brexit-opfer-geworden-16204205.html",
      "urlToImage": "https://media1.faz.net/ppmedia/aktuell/112808907/1.6204201/facebook_teaser/theresa-may-am-freitag-bei.jpg",
      "publishedAt": "2019-05-24T11:07:00Z",
      "content": "David Cameron führt die Liste der Brexit-Opfer an, und nun wird auch seine Nachfolgerin einen Platz darauf finden, zunächst, am 7. Juni, als Parteichefin der Konservativen, etwas später dann auch als Premierministerin. Cameron trat zurück, weil er seine Absti… [+2771 chars]"
    }
  ]
}
```

#### Search Parameters for _Top Headlines_

| Parameter | Info/Description                                                                               | Additional Notes                                              |
| --------- | ---------------------------------------------------------------------------------------------- | ------------------------------------------------------------- |
| q         | Required                                                                                       | Keywords or a phrase to search for.                           |
| country   | The 2-letter ISO 3166-1 code of the country                                                    | You can't mix this param with the _sources_ param.            |
| category  | Options: _business, entertainment, general, health, science, sports, technology_               | You can't mix this param with the _sources_ param.            |
| sources   | A comma-seperated string of identifiers for the news sources or blogs you want headlines from  | You can't mix this param with the country or category params. |
| pageSize  | The number of results to return per page (request). 20 is the default, 100 is the maximum.     |
| page      | Use this to page through the results if the total results found is greater than the page size. |

### Everything

Source: [NewsApi documentation.](https://www.newsapi.org/docs/endpoints)

> We index every recent news and blog article published by over 30,000 different sources large and small, and you can search through them with this endpoint. This endpoint is better suited for news analysis and article discovery, but can be used to retrieve articles for display too.

```ruby
args = { q: 'Huawei', from: (DateTime.now - 2)}

news = NewsApi::Query.new('my-secret-key')

response = news.everything(args)

# =>
```

```json
{
  "status": "ok",
  "totalResults": 4599,
  "articles": [
    {
      "source": {
        "id": "techcrunch",
        "name": "TechCrunch"
      },
      "author": "Catherine Shu",
      "title": "Semiconductor startup CNEX Labs alleged Huawei’s deputy chairman conspired to steal its intellectual property",
      "description": "A San Jose-based semiconductor startup being sued by Huawei for stealing trade secrets has hit back in court documents, accusing the Chinese firm’s deputy chairman of conspiring to steal its intellectual property, reports the Wall Street Journal. In court fil…",
      "url": "http://techcrunch.com/2019/05/22/semiconductor-startup-cnex-labs-alleged-huaweis-deputy-chairman-conspired-to-steal-its-intellectual-property/",
      "urlToImage": "https://techcrunch.com/wp-content/uploads/2019/05/GettyImages-1150756100.jpg?w=600",
      "publishedAt": "2019-05-23T06:01:44Z",
      "content": "A San Jose-based semiconductor startup being sued by Huawei for stealing trade secrets has hit back in court documents, accusing the Chinese firms deputy chairman of conspiring to steal its intellectual property, reports the Wall Street Journal. In court fili… [+3077 chars]"
    }
  ]
}
```

#### Search Parameters for _Everything_

| Parameter      | Info/Description                                                                                                                          | Additional Notes                    |
| -------------- | ----------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------- |
| q              | Required                                                                                                                                  | Keywords or a phrase to search for. |
| sources        | A comma-seperated string of identifiers (maximum 20) for the news sources or blogs you want headlines from.                               |
| domains        | A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to restrict the search to.                               |
| excludeDomains | A comma-seperated string of domains (eg bbc.co.uk, techcrunch.com, engadget.com) to remove from the results.                              |
| from           | A date and optional time for the oldest article allowed. This should be in ISO 8601 format.                                               |
| to             | A date and optional time for the newest article allowed. This should be in ISO 8601 format                                                |
| language       | The 2-letter ISO-639-1 code of the language you want to get headlines for. Possible options: _ar de en es fr he it nl no pt ru se ud zh_. | Default: All languages returned     |
| sortBy         | Options: _relevancy, popularity, publishedAt._                                                                                            | Default: publishedAt                |
| pageSize       | The number of results to return per page. 20 is the default, 100 is the maximum.                                                          |
| page           | Use this to page through the results.                                                                                                     |

### Sources

Source: [NewsApi documentation.](https://www.newsapi.org/docs/endpoints)

> Returns information (including name, description, and category) about the most notable sources we index. This list could be piped directly through to your users when showing them some of the options available.

```ruby
news = NewsApi::Query.new('my-secret-key')
response = news.sources(args)

# =>
```

```json
{
  "status": "ok",
  "sources": [
    {
      "id": "abc-news",
      "name": "ABC News",
      "description": "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com.",
      "url": "https://abcnews.go.com",
      "category": "general",
      "language": "en",
      "country": "us"
    },
    {
      "id": "abc-news-au",
      "name": "ABC News (AU)",
      "description": "Australia's most trusted source of local, national and world news. Comprehensive, independent, in-depth analysis, the latest business, sport, weather and more.",
      "url": "http://www.abc.net.au/news",
      "category": "general",
      "language": "en",
      "country": "au"
    }
  ]
}
```

#### Search Parameters for _Sources_

| Parameter | Info/Description                                                                                                                         |
| --------- | ---------------------------------------------------------------------------------------------------------------------------------------- |
| country   | Find sources that display news in a specific country                                                                                     |
| category  | Options: _business, entertainment, general, health, science, sports, technology_                                                         |
| language  | The 2-letter ISO-639-1 code of the language you want to get headlines for. Possible options: _ar de en es fr he it nl no pt ru se ud zh_ |

## Format

Additionaly, just like with the Gnews module, you may send a second parmeter to specify the format you may want to receive the response.

Supported types: **json** and **hash**

```ruby
args = { q: 'Brexit', country: 'DE' }

news = NewsApi::Query.new('my-secrety-key')

response = news.top_headlines(args, 'hash')
# =>
{
   "status"=>"ok",
   "totalResults"=>1,
   "articles"=>[
      {
         "source"=> {
            "id"=>nil,
            "name"=>"Tagesschau.de"
         },
         "author"=>"tagesschau.de",
         "title"=>"Mays Rücktritt: \"Sie hätte Nationalheldin werden können\" - tagesschau.de", "description"=>"Premierministerin May wollte den Brexit mit aller Kraft. Doch nun hat sie überraschend emotional aufgegeben. Ihre möglichen Nachfolger bringen sich schon in Stellung. Von Imke Köhler.",
         "url"=>"https://www.tagesschau.de/ausland/may-ruecktritt-103.html",
         "urlToImage"=>"https://www.tagesschau.de/multimedia/bilder/may-741~_v-videowebm.jpg",
         "publishedAt"=>"2019-05-24T15:52:00Z",
         "content"=>"Premierministerin May wollte den Brexit mit aller Kraft. Doch nun hat sie überraschend emotional aufgegeben. Ihre möglichen Nachfolger bringen sich schon in Stellung. \r\nVon Imke Köhler, ARD-Studio London\r\n Theresa May hat selten Gefühle gezeigt in den vergang…"
   ]
}


```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viccarrasco/metonym. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Metonym project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/viccarrasco/metonym/blob/master/CODE_OF_CONDUCT.md).
