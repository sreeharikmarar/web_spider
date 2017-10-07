module WebSpider
  class Header
    attr_accessor :header
    def initialize(url)
      @header = initialize_header(url)
    end

    def host
      @header["Host"]
    end

    def initialize_header(url)
      header = Hash.new
      header["Host"] = url.host
      header
    end
  end
end
