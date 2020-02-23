# frozen_string_literal: true

RSpec.describe NewsApi do
  let!(:api_key) { '832c90b74fc946aa9ad5fb589c699b6c' }

  it 'Validates invalid parameter sequence (sources mixed with country)' do
    args = { q: 'Some query', sources: 'sports', country: 'mx' }
    news = NewsApi::Query.new(api_key)
    response = news.top_headlines(args, format: 'json')
    expect(response.key?(:errors)).to eq true
  end

  it 'validates invalid parameter sequence' do
    args = { q: 'Some query', sources: 'sports', country: 'mx' }
    news = NewsApi::Query.new(api_key)
    response = news.top_headlines(args, format: 'invalid-format')
    expect(response.key?(:errors)).to eq true
  end

  it 'validates correctly country' do
    args = { q: 'Elon Musk', country: 'zz' }
    news = NewsApi::Query.new(api_key)
    response = news.top_headlines(args, format: 'json')
    expect(response.key?(:errors)).to eq true
  end

  it 'Validates language' do
    args = { q: 'Elon Musk', country: 'us', lang: 'zz' }
    gnews = NewsApi::Query.new(api_key)
    response = gnews.top_headlines(args, format: 'json')
    expect(response.key?(:errors)).to eq true
  end

  it 'responds successfully a json (top headlines)' do
    args = { q: 'Brexit', country: 'DE' }
    news = NewsApi::Query.new(api_key)
    response = news.top_headlines(args, format: 'json')
    expect(response.is_a?(String)).to eq(true)
  end

  it 'responds successfully a hash (top headlines)' do
    args = { q: 'Brexit', country: 'DE' }
    news = NewsApi::Query.new(api_key)
    response = news.top_headlines(args, format: 'hash')
    expect(response.is_a?(Hash)).to eq(true)
  end

  it 'responds successfully a json (everything)' do
    args = { q: 'China', from: (DateTime.now - 2) }
    news = NewsApi::Query.new(api_key)
    response = news.everything(args, format: 'json')
    expect(response.is_a?(String)).to eq(true)
  end

  it 'responds successfully a json (everything) with date' do
    args = { q: 'Huawei', from: (DateTime.now - 2) }
    news = NewsApi::Query.new(api_key)
    response = news.everything(args, format: 'json')
    expect(response.is_a?(String)).to eq(true)
  end

  it 'responds successfully a json (sources)' do
    args = {}
    news = NewsApi::Query.new(api_key)
    response = news.sources(args, format: 'json')
    expect(response.is_a?(String)).to eq(true)
  end

  it 'validates sources with bad category' do
    args = { 'category' => 'invalid-category' }
    news = NewsApi::Query.new(api_key)
    response = news.sources(args, format: 'json')
    expect(response.key?(:errors)).to eq true
  end
end
