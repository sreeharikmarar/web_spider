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
      parse_document
    end

    def parse_document
      begin
        return unless success_response
        @body = @response.body
        @doc = is_html? ?  Nokogiri::HTML::Document.parse(@body) : nil
      rescue Exception => e
        raise ParserException.new("parser exception : #{e.message}")
      end
    end

    def can_crawl?
      @doc != nil
    end

    def success_response
      @response && @response.msg == "OK" && @response.body != nil
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
