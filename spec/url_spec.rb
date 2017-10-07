require "spec_helper"
require "web_spider/url"

RSpec.describe WebSpider::URL do
  context "Initialize" do
    it "should initialize with a valid url" do
      expect(WebSpider::URL.new("http://www.example.com").host).to eq("www.example.com")
    end
  end

  context "Validate URL" do
    it "should validate given url" do
      expect(WebSpider::URL.new("http://www.example.com").is_valid?).to be true
    end
  end
end
