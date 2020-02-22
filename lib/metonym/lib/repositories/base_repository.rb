# frozen_string_literal: true

class BaseRepository
  def request(uri, query:, resource:)
    uri = URI(uri += resource)
    uri.query = URI.encode_www_form(prepare_arguments(query))
    Net::HTTP.get_response(uri)
  end
end
