# Very DSON [![Build Status](https://travis-ci.org/bolandrm/very_dson.svg?branch=master)](https://travis-ci.org/bolandrm/very_dson)

**Very DSON** is improves the accessibility of your Rails project by allowing you to render your API results in [DSON - Doge Serialized Object Notation](http://dogeon.org/).


## Quick Start

Add the gem to your Gemfile:

```ruby
gem "very_dson", github: "bolandrm/very_dson"
```

Run `bundle install`.

In your controllers, you can now render DSON:

```ruby
class DogeController < ApplicationController
  def index
    render dson: { "foo" => ["bar", "baz", "fizzbuzz"], doge: true }
  end
end
```

This will output the following:

```
such "foo" is so "bar" also "baz" also "fizzbuzz" many? "doge" is yes wow
```


## License

MIT.
