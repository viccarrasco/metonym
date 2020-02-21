# frozen_string_literal: true

module Validate
  class NewsApiQueryValidator < BaseValidator
    COUNTRIES   = %w(ar au at be br bg ca cn co cu cz eg fr de gr hk hu in id ie il it jp lv lt my mx ma nl nz ng no ph pl pt ro ru sa rs sg sk si za kr se ch tw th tr ae ua gb us ve)
    CATEGORIES  = %w(business entertainment general health science sports technology)

    def initialize(args, format)
    end

    private

    def is_query_valid?(args, endpoint = 'top-headlines')
      case endpoint
      when 'top-headlines'
        template = %w(q country category sources page_size page)
      when 'everything'
        template = %w(q sources domains excludeDomains from to language sortBy pageSize page)
      when 'sources'
        template = %w(category language country)
      end

      if (endpoint == 'top-headlines' && (args.include?('sources') && (args.include?('country') || args.include?('category'))))
        false
      elsif (endpoint == 'sources') && (args.has_key?('category')) && (CATEGORIES.include?(args['category']) == false)
        false
      else
        (args.keys - template).empty?
      end
    end

    def is_country_valid?(args)
      args['country'].nil? ? true : COUNTRIES.include?(args['country'].downcase)
    end

    def is_category_valid?(args)
      template = %w(business entertainment general health science sports technology)
      template.include?(args['country'])
    end

    def is_date_valid?(args)
      if (args['from'].nil? && args['to'].nil?)
        true
      elsif (args['from'] && args['to'])
        (args['from'].respond_to?(:strftime) && args['to'].respond_to?(:strftime))
      elsif (args['from'] && args['to'].nil?)
        args['from'].respond_to?(:strftime)
      elsif (args['from'].nil? && args['to'])
        args['from'].respond_to?(:strftime)
      end
    end
  end
end
