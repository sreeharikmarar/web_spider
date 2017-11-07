# WebSpider

A basic ruby gem to crawl websites and create a sitemap file with the visited links details.

## Installation

After checking out this repo `https://github.com/sreeharikmarar/web_spider`

Execute below command to install dependencies

	$ bin/setup

And then execute below command to run tests

	$ rake spec 

And run the below command to install this gem onto your local machine
    
	$ bundle exec rake install

## Usage

	$ web_spider --url "http://somesite.com" --domain "somesite.com" --sitemap "sitemap.xml"

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Todo

- Add support for Cuncurrency
- Add support for Proxy 
- Add support for Cookie/Session

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sreeharikmarar/web_spider. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
