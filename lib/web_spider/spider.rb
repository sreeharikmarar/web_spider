module WebSpider
  class Spider
    def self.run
      options = Options.parse

      crawler = Crawler.new(options)
      crawler.run
    end
  end
end
