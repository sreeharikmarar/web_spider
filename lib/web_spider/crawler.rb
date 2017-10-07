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

      @queue.enqueue(url.name) if url.is_valid?

      until @queue.empty?
        url = @queue.dequeue
        page = get_page(url)
        next if @history.include?(page.url)
        @history.add(page.url)
        page.visit
        crawl_page(page) if page.can_crawl?
      end
    end

    def get_page(url)
      Page.new(url)
    end

    def crawl_page(page)
      page.doc.search('//a[@href]').each do |doc|
        url = URL.new(doc["href"]) if doc["href"] != nil
        @queue.enqueue(url.name) if url.is_valid?
      end
    end

    def initialize_url(url)
      raise WebSpider::InvalidArgument.new("Provide valid url") unless url
      url = URL.new(url)
      raise WebSpider::InvalidUrl.new("provide a valid url") unless url.is_valid?
      url
    end
  end
end
