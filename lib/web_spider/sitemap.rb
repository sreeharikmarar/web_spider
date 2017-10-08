require "builder"

module WebSpider
  class Sitemap
    attr_accessor :sitemap, :images

    def initialize(file_path)
      @sitemap = File.new(file_path,"w")
      @images = Array.new
    end

    def add_images(img_url)
      @images << img_url
    end

    def update_sitemap(url_string)
      builder = Builder::XmlMarkup.new(:indent=>2)
      entry = builder.url { |url| url.loc(url_string); update_images(url); }
      File.open(@sitemap,"ab") do |f|
        f.write(entry)
      end
      @images.clear
    end

    def update_images(url)
      @images.uniq.each { |image| url.img { |img| img.src(image) }} if @images.any?
    end
  end
end
