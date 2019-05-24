RSpec.describe Metonym do
  API_KEY = "my-secret-key" # change this for your actual key

  it "Gnews: Should  validate errors" do
    args = { "q" => "Some query", "mindate" => (DateTime.now - 2), "invalid" => "param" }
    gnews = Gnews::Query.new(API_KEY)
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "Gnews: Should  validate country" do
    args = { "q" => "Elon Musk", "mindate" => (DateTime.now - 2), "country" => 'zz' }
    gnews = Gnews::Query.new(API_KEY)
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "Gnews: Should  validate language" do
    args = { "q" => "Elon Musk", "mindate" => (DateTime.now - 2), "country" => 'us', "lang" => 'zz'}
    gnews = Gnews::Query.new(API_KEY)
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "Gnews: Should  validate date" do
    args = { "q" => "Game of Thrones", "mindate" => "invalid date"}
    gnews = Gnews::Query.new(API_KEY)
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  # it "Gnews: Should  respond successfully a json" do
  #   args = { "q" => "Lupin III", "country" => "US", "mindate" => (DateTime.now - 2) }
  #   gnews = Gnews::Query.new(API_KEY)
  #   response = gnews.search(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end

  # it "Gnews: Should  respond successfully a hash" do
  #   args = { "q" => "Dragon Ball Super", "country" => "MX", "mindate" => (DateTime.now - 2) }
  #   gnews = Gnews::Query.new(API_KEY)
  #   response = gnews.search(args, 'hash')
  #   expect(response.is_a?(Hash)).to eq(true)
  # end

  it "Gnews: Should respond with invalid format error" do
    args = { "q" => "Dragon Ball Super", "country" => "MX", "mindate" => (DateTime.now - 2) }
    gnews = Gnews::Query.new(API_KEY)
    response = gnews.search(args, 'invalid')
    expect(response.has_key?("errors")).to eq true
  end

  it "NewsApi: Should validate invalid parameter sequence (sources mixed with country)" do
    args = { "q" => "Some query", "sources" => 'sports', "country" => "mx" }
    news = NewsApi::Query.new(API_KEY)
    response = news.top_headlines(args)
    expect(response.has_key?("errors")).to eq true
  end

    it "NewsApi: Should validate invalid format" do
    args = { "q" => "Some query", "sources" => 'sports', "country" => "mx" }
    news = NewsApi::Query.new(API_KEY)
    response = news.top_headlines(args, 'invalid-format')
    expect(response.has_key?("errors")).to eq true
  end

  it "NewsApi: Should  validate country" do
    args = { "q" => "Elon Musk", "country" => 'zz' }
    news = NewsApi::Query.new(API_KEY)
    response = news.top_headlines(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "NewsApi: Should  validate language" do
    args = { "q" => "Elon Musk", "country" => 'us', "lang" => 'zz'}
    gnews = NewsApi::Query.new(API_KEY)
    response = gnews.top_headlines(args)
    expect(response.has_key?("errors")).to eq true
  end

  # it "NewsApi: Should  respond successfully a json (top headlines)" do
  #   args = { "q" => "Brexit", "country" => "DE" }
  #   news = NewsApi::Query.new(API_KEY)
  #   response = news.top_headlines(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end

  # it "NewsApi: Should  respond successfully a hash (top headlines)" do
  #   args = { "q" => "Brexit", "country" => "DE" }
  #   news = NewsApi::Query.new(API_KEY)
  #   response = news.top_headlines(args, 'hash')
  #   expect(response.is_a?(Hash)).to eq(true)
  # end

  # it "NewsApi: Should  respond successfully a json (everything)" do
  #   args = { "q" => "Game of Thrones", "from" => (DateTime.now - 2) }
  #   news = NewsApi::Query.new(API_KEY)
  #   response = news.everything(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end

  #  it "NewsApi: Should  respond successfully a json (everything) with date" do
  #   args = { "q" => "Huawei", "from" => (DateTime.now - 2)}
  #   news = NewsApi::Query.new(API_KEY)
  #   response = news.everything(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end

  # it "NewsApi: Should  respond successfully a json (sources)" do
  #   args = {}
  #   news = NewsApi::Query.new(API_KEY)
  #   response = news.sources(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end

  it "NewsApi: Should validate sources with bad category" do
    args = {"category" => "invalid-category"}
    news = NewsApi::Query.new(API_KEY)
    response = news.sources(args)
    expect(response.has_key?("errors")).to eq true
  end

  # it "NewsApi: Should  respond successfully a json (sources) with valid category" do
  #   args = {"category" => "sports"}
  #   news = NewsApi::Query.new(API_KEY)
  #   response = news.sources(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end
end
