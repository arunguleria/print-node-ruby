# PrintNode

[![Gem Version](https://badge.fury.io/rb/print-node-ruby.svg)](https://badge.fury.io/rb/print-node-ruby)[![Code Climate](https://codeclimate.com/github/arunguleria/print-node-ruby/badges/gpa.svg)](https://codeclimate.com/github/arunguleria/print-node-ruby)

Ruby wrapper for [Print Node APIs](https://www.printnode.com/docs/api/curl).

You must be a registered user of these APIs to use this gem.

__Features__

* ViewPrinters
* PrintJob(PDF File)
* GetPrinterDetail

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'print_node'
```

And then execute:

`$ bundle`

Or install it yourself as:

`$ gem install print_node`

## Usage

### Configuration Options

By default credentials are taken from the local environment, for this to work the following ENV variables must be set:

* `ENV['USERNAME']`
* `ENV['PASSWORD']`

You can also configure credentials via ` PrintNode::Client.new`:

```ruby
client = PrintNode::Client.new.tap do |config|
  config.username      = ENV['USERNAME']
  config.password      = ENV['PASSWORD']
end
```

Client connections can be passed to each method:

```ruby
PrintNode::PrintJob.new(client.connection)
```

Documentation is available [here](http://www.rubydoc.info/github/arunguleria/print-node-ruby)

Some usage examples are also available [here](example/mock.rb)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

## Contributing

1. Fork it ( https://github.com/arunguleria/print-node-ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
