begin
  require 'robots'
  require 'pry'
rescue LoadError
end

module WebSpider
  class Crawler
    attr_reader :url

    def initialize(url)
      sanitize_url(url)
      validate_url
    end

    def is_allowed?
      robot = Robots.new("web spider User Agent")
      robot.allowed?(@url)
    end

    def run
      puts "starts crawling"
    end

    def sanitize_url(url)
      raise WebSpider::InvalidArgument.new("Please provide URL string as first argument") if url.nil? || url.length < 1
      @url = url
    end

    def validate_url
      raise WebSpider::InvalidUrl.new("Please provide a valid URL") unless valid_url?
    end

    def valid_url?
      uri = URI.parse(@url)
      (uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)) && !uri.host.nil?
    rescue URI::InvalidURIError
      false
    end
  end
end
