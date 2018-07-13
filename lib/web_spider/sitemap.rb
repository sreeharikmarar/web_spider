require "builder"

module WebSpider
  class Sitemap
    attr_reader :sitemap, :images

    def initialize(file_path)
      @sitemap = File.open(file_path, File::WRONLY | File::APPEND | File::CREAT)
      @images = Array.new
    end

    def add_images(img_url)
      @images << img_url
    end

    def update_sitemap(url_string)
      builder = Builder::XmlMarkup.new(:indent=>2)
      entry = builder.url { |url| url.loc(url_string); update_images(url); }
      @sitemap.write(entry)
      @images.clear
    end

    def update_images(url)
      @images.uniq.each { |image| url.img { |img| img.src(image) }} if @images.any?
    end
  end
end
