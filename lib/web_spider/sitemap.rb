require "builder"

module WebSpider
  class Sitemap
    attr_accessor :sitemap, :builder

    def initialize(file_path)
      @sitemap = File.new(file_path,"w")
      @builder = Builder::XmlMarkup.new(:indent=>2)
    end

    def add_html(url_string)
      entry = @builder.url { |url| url.location(url_string) }
      File.open(@sitemap,"ab") do |f|
        f.write(entry)
      end
    end
  end
end
