# Kave (Kemal API Version Extension)

This shards makes it easier to version your [Kemal](http://kemalcr.com/) API

**WARNING:** experimental stage. Nothing really works yet...

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  kave:
    github: jwoertink/kave
```


## Usage


```crystal
require "kemal"
require "kave"

Kave.configure do |c|
  c.strategy = :path # see Strategies below for more options
end

get "/" do |env|
  "This is a public route"
end

api("v1") do
  get "/" do |env|
    "This is a private route only accessed through the version 1 API"
  end
end

api("v2") do
  get "/" do |env|
    "This is a private route only accessed through the version 2 API"
  end
end
```

### Strategies

## Development


## Contributing

1. Fork it ( https://github.com/jwoertink/kave/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jwoertink(https://github.com/jwoertink) Jeremy Woertink - creator, maintainer
