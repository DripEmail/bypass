# frozen_string_literal: true

module Bypass
  class Filter
    attr_reader :content, :fragment

    URL_PATTERN = %r{
      # Protocol
      \bhttps?://

      # Middle characters
      [a-zA-Z0-9\-\._~:/\?#\[\]@!$&'\(\)\*\+,;=%]+

      # End character
      [a-zA-Z0-9\-_~/#\[\]@$&\*\+=%]
    }x.freeze

    def initialize(content, options = {})
      @content = content.to_s.encode('UTF-8')
      @fragment = options.fetch(:fragment, true)
    end

    def replace
      raise NotImplementedError
    end

    def to_s
      content
    end

    private

    def gsub_urls(text)
      text.gsub(URL_PATTERN) do |match|
        yield(match.to_s)
      end
    end

    def parse_uri(uri)
      Bypass::URI.parse(uri.to_s.strip)
    rescue StandardError
      nil
    end
  end
end
