require "net/http"
require "nokogiri"
require "open-uri"
require "pry"

module WebSpider
  class Page
    attr_reader :url
    attr_accessor :header, :body, :response, :doc

    def initialize(url)
      @url = url
    end

    def visit
      puts "Crawling URL : #{@url}"
      uri = URI(@url)
      @response = Net::HTTP.get_response(uri)
      case @response
      when Net::HTTPSuccess
        parse_document
      when Net::HTTPUnauthorized
        puts ">> unauthorized"
      when Net::HTTPServerError
        puts ">> error"
      else
        puts ">> error"
      end
    end

    def parse_document
      @header = @response.header.to_hash
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

    def is_html?
      is_content_type?("html")
    end

    def content_types
      @response.get_fields('content-type') || []
    end

    def is_content_type?(type)
      if type.include?('/')
        content_types.any? do |value|
          value = value.split(';',2).first
          value == type
        end
      else
        content_types.any? do |value|
          value = value.split(';',2).first
          value = value.split('/',2).last
          value == type
        end
      end
    end
  end
end
