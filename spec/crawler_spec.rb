require "spec_helper"

require "web_spider/crawler"
require "web_spider/error"
require "web_spider/options"
require "web_spider/history"

RSpec.describe WebSpider::Crawler do
  context "Initialize" do
    it "should initialize with valid argument" do
      options = {:url => "sample.com", :host => "sample.com"}
      expect { WebSpider::Crawler.new(options).run }.to raise_exception(WebSpider::InvalidURL)
    end
  end
end
