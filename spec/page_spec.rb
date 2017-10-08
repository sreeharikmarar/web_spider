require "spec_helper"

require "web_spider/page"
require "pry"

RSpec.describe WebSpider::Crawler do
  context "Initialize" do
    it "should initialize with valid argument" do
      expect { WebSpider::Page.new("http://sample.com", "",)}.not_to raise_exception()
    end
  end

  context "Parse Response with empty body" do
    let(:url) { 'http://abc.com' }
    let(:host) { 'abc.com' }
    let(:body) { '' }

    let(:response) do
      Net::HTTPResponse.new('1.1', "200", "OK").tap do |response|
        response.set_content_type("application/html")
        allow(response).to receive(:body).and_return(body)
      end
    end

    let (:page) { WebSpider::Page.new(url, response, host) }

    it "should check if page content type is application/html" do
      page.visit
      expect(page.is_html?).to be true
    end

    it "should return null when body is empty" do
      page.visit
      expect(page.body).to eq("")
    end
  end

  context "Parse Response with html content" do
    let(:url) { 'http://abc.com' }
    let(:host) { 'abc.com' }
    let(:body) { "<html><a hred='http://abs.com/about'></a></html>" }

    let(:response) do
      Net::HTTPResponse.new('1.1', "200", "OK").tap do |response|
        response.set_content_type("application/html")
        allow(response).to receive(:body).and_return(body)
      end
    end

    let (:page) { WebSpider::Page.new(url, response, host) }

    it "should return href elemeents while parsing" do
      page.visit
      expect(page.body).to eq("<html><a hred='http://abs.com/about'></a></html>")
    end
  end
end
