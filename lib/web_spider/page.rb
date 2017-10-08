require "nokogiri"
require "net/http"
require "open-uri"
require "pry"

module WebSpider
  class Page
    attr_reader :url, :host
    attr_accessor :header, :body, :response, :doc

    def initialize(url,response, host=nil)
      @url = url
      @response = response
      @host = host
    end

    def visit
      puts "Crawling URL : #{@url}"
      parse_document
    end

    def parse_document
      @body = @response.body
      if is_html?
        @doc = Nokogiri::HTML::Document.parse(@body)
      else
        @doc = nil
      end
    end

    def can_crawl?
      @doc != nil
    end

    def should_skip(host)
      @host == host
    end

    def is_html?
      is_content_type?("html")
    end

    def content_types
      @response.get_fields('content-type') || []
    end

    def is_content_type?(type)
      content_types.any? do |value|
        value = value.split(';',2).first
        value = value.split('/',2).last
        value == type
      end
    end
  end
end
