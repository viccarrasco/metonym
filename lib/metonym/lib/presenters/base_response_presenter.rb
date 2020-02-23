# frozen_string_literal: true

class BaseResponsePresenter
  def generate_formatted_response(response, format)
    return response if response.is_a?(Hash) && response.key?(:errors)

    case format
    when nil
      response.body
    when 'json'
      response.body
    when 'hash'
      JSON.parse(response.body)
    else
      response.body
    end
  end
end
