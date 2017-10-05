require "spec_helper"

RSpec.describe WebSpider do
  context "Initialize" do
    it "should not initialize without proper argument" do
      expect { WebSpider::Spider.run }.to raise_exception(WebSpider::InvalidArgument)
    end

    it "should not start if url is invalid" do
      expect { WebSpider::Spider.run("test") }.to raise_exception(WebSpider::InvalidUrl)
    end
  end
end
