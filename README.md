# Totangorb

Lightweight Ruby wrapper for [Totango](http:/http://www.totango.com/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'totangorb'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install totangorb

## Usage

Type:

    $ rails g totangorb:install

It will generate an initializer for you

```ruby
unless defined?($totango)
  $totango = if Rails.env.production?
    Totangorb::Tracker.new('1234xxxx')
  else
    Totangorb::Tracker.new('1234xxxx', debug: true, logger: Rails.logger)
  end
end
```

`debug: true` - do not make real HTTP requests - useful in development environment

You can also set your custom `logger`, such as `Rails.logger` to log every request made to Totango.

These parameters are totally optional.

Replace `1234xxxx` with your Totango API service id. From now you can make requests to Totango within your application:

```ruby
$totango.track do |t|
  t.username     "Username"
  t.account_id   "1234"
  t.account_name "Account name"
  t.activity     "Sample event"
  t.module       "Event module within application"
  t.attributes   {}
end
```

Account attributes is optional - its a hash of custom attributes, you can really put whatever you want there, but remember to also set them in your Totango account.

For more informations, please visit [Totango Quick Start: HTTP API (Server side integration)](http://help.totango.com/installing-totango/quick-start-http-api-server-side-integration/)

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author
Michał Darda &copy; 2013 <michaldarda@gmail.com>
