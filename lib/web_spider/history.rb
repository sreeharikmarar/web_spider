module WebSpider
  class History
    attr_accessor :history

    def initialize
      @history = Array.new
    end

    def include?(url)
      @history.include?(url)
    end

    def add(url)
      @history.push(url)
    end

    def clear
      @history = Array.new
    end
  end
end
