require 'optparse'

module WebSpider
  class Options

    def self.parse
      options = Hash.new

      opt_parser = OptionParser.new do |opts|
        opts.banner = "\nUsage:\n   web_spider [options]"

        opts.separator ""
        opts.separator "Options:"

        opts.on("-u", "--url URL", "Full URL to start crawling, eg: http://google.com") do |url|
          options[:url] = url
        end

        opts.on("-h", "--help", "Prints help") do
          puts opts
          exit
        end
      end

      begin
        opt_parser.parse!
        mandatory = [:url]
        missing = mandatory.select{ |param| options[param].nil? }
        raise OptionParser::MissingArgument, missing.join(', ') unless missing.empty?
      rescue OptionParser::ParseError,OptionParser::MissingArgument => e
        puts e
        puts opt_parser
        exit
      end

      return options
    end
  end
end
