require 'robots'
require 'pry'
require 'optionparser'

module WebSpider
  class Crawler
    attr_accessor :queue, :history, :options, :sitemap

    def initialize(options)
      @options = options
      @queue = Queue.new
      @history = History.new
      @sitemap = Sitemap.new(@options[:sitemap])
    end

    def is_allowed?
      robot = Robots.new("web spider User Agent")
      robot.allowed?(@url)
    end

    def run
      url = URL.new(@options[:url])
      raise InvalidURL.new("given URL '#{url.name}'' is invalid") unless url.is_valid?

      @queue.enqueue(url.name)
      start_crawling
    end

    def start_crawling
      until @queue.empty?
        url = @queue.dequeue
        next if @history.include?(url)
        puts "Crawling URL : #{url}"
        response = Server.get_response(url)
        page = get_page(url,response)
        page.visit
        @history.add(url)
        crawl_page(page) if page.can_crawl?
      end
    end

    def domain
      @options[:domain]
    end

    def get_page(url,response)
      domain != nil ? Page.new(url,response,domain) : Page.new(url,response)
    end

    def crawl_page(page)
      update_sitemap(page.url)
      page.doc.search('//a[@href]').each do |doc|
        url = URL.new(doc["href"]) if doc["href"] != nil
        next if not_allowed?(url)
        @queue.enqueue(url.name) if url.is_valid?
      end
    end

    def update_sitemap(url)
      @sitemap.add_html(url)
    end

    def not_allowed?(url)
      url.is_valid? && domain != nil && domain != url.host
    end
  end
end
