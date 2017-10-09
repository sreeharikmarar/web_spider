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

    def is_allowed?(url)
      robot = Robots.new("web spider User Agent")
      robot.allowed?(url)
    end

    def run
      url = URL.new(@options[:url])
      raise InvalidURL.new("given URL '#{url.name}'' is invalid") unless url.is_valid?

      @queue.enqueue(url.name)

      begin
        start_crawling
      rescue ParserException => e
        puts e.message
      end
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
      search_images(page)
      update_sitemap(page.url)
      search_urls(page)
    end

    def search_images(page)
      page.doc.search('//img[@src]').each do |img|
        @sitemap.add_images(img["src"]) if img["src"] != nil
      end
    end

    def search_urls(page)
      page.doc.search('//a[@href]').each do |doc|
        url = URL.new(doc["href"]) if doc["href"] != nil
        next if not_allowed?(url)
        @queue.enqueue(url.name) if url.is_valid?
      end
    end

    def update_sitemap(url)
      @sitemap.update_sitemap(url)
    end

    def not_allowed?(url)
      url.is_valid? && domain != nil && domain != url.host
    end
  end
end
