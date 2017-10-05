require "spec_helper"

RSpec.describe WebSpider::Crawler do
  context "Initialize" do
    it "should not initialize with an invalid argument" do
      expect { WebSpider::Crawler.new("") }.to raise_exception(WebSpider::InvalidArgument)
    end

    it "should not initialize with an invalid url" do
      expect { WebSpider::Crawler.new("sample") }.to raise_exception(WebSpider::InvalidUrl)
    end

    it "should initialize with a valid url" do
      expect(WebSpider::Crawler.new("http://sample.com").valid_url? ).to be true
    end

  end

end
