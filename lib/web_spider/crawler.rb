require 'robots'
require 'pry'
require 'optionparser'

module WebSpider
  class Crawler
    attr_accessor :queue, :history, :options

    def initialize(options)
      @options = options
      @queue = Queue.new
      @history = History.new
    end

    def is_allowed?
      robot = Robots.new("web spider User Agent")
      robot.allowed?(@url)
    end

    def run
      url = URL.new(@options[:url])

      raise InvalidURL.new("Invalid URL") unless url.is_valid?

      @queue.enqueue(url.name)

      until @queue.empty?
        url = @queue.dequeue
        next if @history.include?(url)
        response = Server.get_response(url)
        page = get_page(url,response)
        page.visit
        @history.add(url)
        crawl_page(page) if page.can_crawl?
      end
    end

    def host
      @options[:host]
    end

    def get_page(url,response)
      host != nil ? Page.new(url,response,host) : Page.new(url,response)
    end

    def crawl_page(page)
      page.doc.search('//a[@href]').each do |doc|
        url = URL.new(doc["href"]) if doc["href"] != nil
        next if not_allowed?(url)
        @queue.enqueue(url.name) if url.is_valid?
      end
    end

    def not_allowed?(url)
      url.is_valid? && host != nil && host != url.host
    end

    def initialize_url(url)
      raise WebSpider::InvalidArgument.new("Provide valid url") unless url
      url = URL.new(url)
      raise WebSpider::InvalidUrl.new("provide a valid url") unless url.is_valid?
      url
    end
  end
end
