# Kave (Kemal API Version Extension)

This shards makes it easier to version your [Kemal](http://kemalcr.com/) API

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
  c.strategy = :bearer
  c.token_model = Kave::AuthToken
end

get "/" do |env|
  "This is a public route"
end

Kave.get "/" do |env|
  "This is a private route only accessed through the API"
end
```

## Development


## Contributing

1. Fork it ( https://github.com/jwoertink/kave/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [jwoertink(https://github.com/jwoertink) Jeremy Woertink - creator, maintainer
