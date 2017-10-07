module WebSpider
  class Queue
    attr_accessor :queue

    def initialize
      @queue = Array.new
    end

    def dequeue
      @queue.pop
    end

    def enqueue(element)
      @queue.unshift(element)
      self
    end

    def empty?
      @queue.empty?
    end
  end
end
