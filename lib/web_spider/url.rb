require "open-uri"

module WebSpider
  class URL
    attr_accessor :name

    def initialize(name)
      @name = name
    end

    def host
      URI.parse(@name).host
    end

    def validate_url
      raise InvalidUrl.new("Please provide a valid URL") unless is_valid?
    end

    def is_valid?
      uri = URI.parse(@name)
      (uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
    end
  end
end
