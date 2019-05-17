RSpec.describe Metonym do
  it "Should validate errors" do
    args = { "q" => "Some query", "mindate" => (DateTime.now - 2), "invalid" => "param" }
    gnews = Gnews::Query.new('my-secret-key')
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "Should validate country" do
    args = { "q" => "Elon Musk", "mindate" => (DateTime.now - 2), "country" => 'zz' }
    gnews = Gnews::Query.new('my-secret-key')
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "Should validate language" do
    args = { "q" => "Elon Musk", "mindate" => (DateTime.now - 2), "country" => 'us', "lang" => 'zz'}
    gnews = Gnews::Query.new('my-secret-key')
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  it "Should validate date" do
    args = { "q" => "Game of Thrones", "mindate" => "invalid date"}
    gnews = Gnews::Query.new('my-secret-key')
    response = gnews.search(args)
    expect(response.has_key?("errors")).to eq true
  end

  # it "Should respond successfully a json" do
  #   args = { "q" => "Lupin III", "country" => "US", "mindate" => (DateTime.now - 2) }
  #   gnews = Gnews::Query.new('my-secret-key')
  #   response = gnews.search(args)
  #   expect(response.is_a?(String)).to eq(true)
  # end

  # it "Should respond successfully a hash" do
  #   args = { "q" => "Dragon Ball Super", "country" => "MX", "mindate" => (DateTime.now - 2) }
  #   gnews = Gnews::Query.new('my-secret-key')
  #   response = gnews.search(args, 'hash')
  #   expect(response.is_a?(Hash)).to eq(true)
  # end
end
