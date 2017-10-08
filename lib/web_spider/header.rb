module WebSpider
  class Header
    attr_accessor :header

    def initialize(url)
      @header = initialize_header(url)
    end

    def host
      @header[:host]
    end

    def initialize_header(url)
      header = Hash.new
      header[:host] = url.host
      header
    end
  end
end
