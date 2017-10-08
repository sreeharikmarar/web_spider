$LOAD_PATH << File.join(File.dirname(__FILE__), "web_spider")

require "web_spider/spider"
require "web_spider/crawler"
require "web_spider/queue"
require "web_spider/history"
require "web_spider/header"
require "web_spider/page"
require "web_spider/url"
require "web_spider/options"
require "web_spider/server"
require "web_spider/error"
