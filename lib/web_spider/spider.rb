module WebSpider
  class Spider
    def self.run *args
      crawler = WebSpider::Crawler.new(args[0])
      crawler.run
    end
  end
end
