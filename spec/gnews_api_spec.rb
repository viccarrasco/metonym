# frozen_string_literal: true

RSpec.describe Gnews do
  let(:api_key) { 'd379bd85db0397857d803ff3da4b55e4' }

  it 'Gnews: Should  validate errors' do
    args = { q: 'Some query', mindate: DateTime.now - 2, invalid: 'param' }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'json')
    expect(response.has_key?('errors')).to eq true
  end

  it 'Gnews: Should  validate country' do
    args = { 'q' => 'Elon Musk', 'mindate' => (DateTime.now - 2), 'country' => 'zz' }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'json')
    expect(response.has_key?('errors')).to eq true
  end

  it 'Gnews: Should  validate language' do
    args = { 'q' => 'Elon Musk', 'mindate' => (DateTime.now - 2), 'country' => 'us', 'lang' => 'zz' }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'json')
    expect(response.has_key?('errors')).to eq true
  end

  it 'Gnews: Should  validate date' do
    args = { 'q' => 'Game of Thrones', 'mindate' => 'invalid date' }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'json')
    expect(response.has_key?('errors')).to eq true
  end

  it 'Gnews: Should  respond successfully a json', focus: true do
    args = { 'q' => 'Lupin III', 'country' => 'US', 'mindate' => (DateTime.now - 2) }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'json')
    expect(response.is_a?(String)).to eq(true)
  end

  it 'Gnews: Should  respond successfully a hash' do
    args = { 'q' => 'Dragon Ball Super', 'country' => 'MX', 'mindate' => (DateTime.now - 2) }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'hash')
    expect(response.is_a?(Hash)).to eq(true)
  end

  it 'Gnews: Should respond with invalid format error' do
    args = { 'q' => 'Dragon Ball Super', 'country' => 'MX', 'mindate' => (DateTime.now - 2) }
    gnews = Gnews::Query.new(api_key)
    response = gnews.search(args, format: 'invalid')
    expect(response.has_key?('errors')).to eq true
  end
end
