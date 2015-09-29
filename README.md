# FilmOn

A Ruby wrapper for the FilmOn API: http://www.filmon.com/page/api

This is currently at version 0.0.1 and only handles channels, channel
and groups methods


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'film_on'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install film_on

## Usage

Refer to FilmOn Api (http://www.filmon.com/page/api):

Obtain your app_key and app_secret from FilmOn 

app_key = "foo"
app_secret = "bar"

film_on = FilmOn::Base.new(app_key, app_secret)

film_on.channels => returns list of all channels as ruby objects
flim_on.groups => returns list of all groups as ruby objects
film_on.channel(id) => returns info for given channel as a ruby object

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/thelazycamel/film_on.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

