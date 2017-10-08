module WebSpider
  class Spider
    def self.run
      begin
        options = Options.parse
        crawler = Crawler.new(options)
        crawler.run
      rescue SystemExit
        exit
      rescue InvalidURL => e
        puts ">>Invalid URL Exception: #{e.message}"
      rescue ParserException => e
        puts ">>Parser Exception: #{e.message}" 
      rescue Exception => e
        puts ">>Exception: #{e.message}"
      end
    end
  end
end
