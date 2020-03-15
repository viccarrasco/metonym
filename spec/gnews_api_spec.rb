# frozen_string_literal: true

RSpec.describe Gnews do
  let(:api_key) { 'd379bd85db0397857d803ff3da4b55e4' }

  describe '#validate' do
    it 'validates and respond with errors' do
      args = { q: 'Some query', mindate: (DateTime.now - 2), invalid: 'param' }
      gnews = Gnews::Query.new(api_key)
      response = gnews.search(args, format: 'json')
      expect(response.key?(:errors)).to eq true
    end

    it 'validates country and responds with country error' do
      args = { q: 'Elon Musk', mindate: (DateTime.now - 2), country: 'zz' }
      gnews = Gnews::Query.new(api_key)
      response = gnews.search(args, format: 'json')
      expect(response.key?(:errors)).to eq true
    end

    it 'validates language and responds with language error' do
      args = { q: 'Elon Musk', mindate: (DateTime.now - 2), country: 'us', lang: 'zz' }
      gnews = Gnews::Query.new(api_key)
      response = gnews.search(args, format: 'json')
      expect(response.key?(:errors)).to eq true
    end

    it 'validates date and responds with error of date' do
      args = { q: 'Game of Thrones', mindate: 'invalid date' }
      gnews = Gnews::Query.new(api_key)
      response = gnews.search(args, format: 'json')
      expect(response.key?(:errors)).to eq true
    end
  end

  describe '#search' do
    context 'when type of query is: search' do
      it 'responds successfully with json' do
        args = { q: 'Covid-19', country: 'de', lang: 'en', mindate: (DateTime.now - 2) }
        gnews = Gnews::Query.new(api_key)
        response = gnews.search(args)
        expect(response.is_a?(String)).to eq(true)
      end

      it 'responds successfully with a hash' do
        args = { q: 'Dragon Ball Super', country: 'MX', mindate: (DateTime.now - 2) }
        gnews = Gnews::Query.new(api_key)
        response = gnews.search(args, format: 'hash')
        expect(response.is_a?(Hash)).to eq(true)
      end
    end

    context 'when type of query is: top-news' do
      let!(:args)  { { lang: 'en', country: 'DE', max: 10 } }
      let!(:gnews) { gnews = Gnews::Query.new(api_key) }
      subject { gnews.top_news(args, format: format) }

      context 'when format is json' do
        let(:format) { 'json' }
        it 'it responds successfully with json' do
          expect(subject.is_a?(String)).to eq(true)
        end
      end

      context 'when format is hash' do
        let(:format) { 'hash' }
        it 'it responds successfully with a hash' do
          expect(subject.is_a?(Hash)).to eq(true)
        end
      end

      context 'when format is not set or an invalid format' do
        let(:format) { 'invalid' }
        it 'it responds with json when invalid format sent' do
          expect(subject.is_a?(String)).to eq(true)
        end
      end
    end
  end
end
