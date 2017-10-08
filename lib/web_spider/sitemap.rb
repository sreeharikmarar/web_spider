module WebSpider
  class Sitemap
    attr_accessor :sitemap

    def initialize(file_path)
      @sitemap = File.new(file_path,"w")
    end

    def add_html(url)
      string = "<url><location>#{url}</location></url>\n"
      File.open(@sitemap,"ab") do |f|
        f.write(string)
      end
    end
  end
end
