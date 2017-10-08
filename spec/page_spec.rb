require "spec_helper"

require "web_spider/page"
require "pry"

RSpec.describe WebSpider::Crawler do
  context "Initialize" do
    it "should initialize with valid argument" do
      expect { WebSpider::Page.new("http://sample.com", "",)}.not_to raise_exception()
    end
  end

  context "Crawl Page" do
    let(:url) { 'http://abc.com' }
    let(:host) { 'abc.com' }
    let(:body) { '' }

    let(:response) do
      Net::HTTPResponse.new('1.1', "200", "OK").tap do |response|
        response.set_content_type("application/html")
        allow(response).to receive(:body).and_return(body)
      end
    end

    it "should check if page content type is application/html" do
      page = WebSpider::Page.new(url, response, host)
      expect(page.is_html?).to be true
    end

    it "should check if page content type is application/html" do
      page = WebSpider::Page.new(url, response, host)
      expect(page.is_html?).to be true
    end
  end
end
