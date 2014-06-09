# Very DSON

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


## License

MIT.