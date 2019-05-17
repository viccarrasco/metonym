# Metonym

A ruby gem for [GNews API](https://gnews.io)


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'metonym'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install metonym

## Usage

To be able to send requests to the GNews API, you first must create an account to receive a token [here](https://gnews.io/register.php).

## Query
```ruby
# Establish parameters for query
args = { "q" => "Dragon Ball Super", "country" => "MX", "mindate" => (DateTime.now - 2), 'max' => 1 }

# Send Request
gnews = Gnews::Query.new('my-secret-key')
response = gnews.search(args)

puts response

# =>
```

```json
{  
   "timestamp":1558081205,
   "count_results":1,
   "articles":[  
      {  
         "title":"'Dragon Ball Super' Chapter 48 Release Date, Predictions: Moro Not the Real Villain, Truth Revealed?",
         "desc":"It has been quite a long wait, but it wou ld appear that Dragon Ball Super Chapter 48 will be coming out soon. Along with it is rumored to be a huge bombshell ...",
         "link":"https://www.econotimes.com/Dragon-Ball-Super-Chapter-48-Release-Date-Predictions-Moro-Not-the-Real-Villain-Truth-Revealed-1538175",
         "website":"https://www.econotimes.com",
         "source":"EconoTimes",
         "date":"Fri, 17 May 2019 05:43:46 GMT",
         "image":"https://lh4.googleusercontent.com/proxy/CDTeHID-9i5aNWFXTOImYAOOBAFyv8R_QewR4cwP38bycKmVpNS8W-dawVxxumt8FhuzPjXhql8c1y36tkmTaEBW5bCUhryqWH-RBtLnScf_-X8QNL-899A9Sxh2BRpN4Pkp=-c"
      }
   ]
}
```

You can also send a second parmeter to the search method to indicate that the response be parsed to a ruby hash for easier manipulation. By default, the request will respond with a JSON.

```ruby
# Establish parameters for query
args = { "q" => "Game of Thrones", "country" => "DE", 'max' => 1 }

# Send Request with HASH response property
gnews = Gnews::Query.new('my-secret-key', 'hash') 
response = gnews.search(args)

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
| Parameter 	| Info   	                                | Description
|---	        |---	                                    |---
|  q	        |  Required                                 | Your search
|  max	        |  Optional (default value : 10)	        | The number of items you want (max possible : 100)
|  lang 	    |  Optional (default value : english) 	    | The article language ([list of all languages](https://gnews.io/documentation.php#NationList))
|  country	    |  Optional (default value : United-States) | The article origin ([list of all countries](https://gnews.io/documentation.php#NationList))
|  mindate 	    |  Optional (Date/DateTime)                 | Get articles that are more recent than the min date
|  maxdate	    |  Optional (Date/DateTime)                 | Get articles that are less recent than the max date
|  in 	        |  Optional 	                            | Get articles that contains q in the specified article section

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viccarrasco/metonym. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Metonym project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/viccarrasco/metonym/blob/master/CODE_OF_CONDUCT.md).
