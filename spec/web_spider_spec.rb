require "spec_helper"
require "web_spider/spider"

RSpec.describe WebSpider::Spider do
  context "Initialize" do
    it "should not start without proper argument" do
      expect { WebSpider::Spider.run }.to raise_error(SystemExit)
    end
  end
end
