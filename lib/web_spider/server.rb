module WebSpider
  class Server
    class << self
      def get_response(uri_str, limit = 10)
        begin
          result = Net::HTTP.get_response(URI.parse(uri_str))
          case result
          when Net::HTTPSuccess     then result
          when Net::HTTPRedirection then get_response(result['location'], limit - 1)
          else
            result.error!
          end
        rescue Exception => e
          puts e.message
          return false
        end
      end
    end
  end
end
