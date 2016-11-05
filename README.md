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

## Configuration Options

You can configure Kave to handle your API in different ways.

```crystal
Kave.configure do |c|
  c.strategy = :path
end
```

To check your current configuration you can use `Kave.configuration` to return the instance of `Kave::Config`

### Strategies

These are the options for `c.strategy` in your configure block

* `:path` - This option prepends the api version to each route. `/users` becomes `/v1/users`

* `:header` - This option checks your route by using special headers


### Authorizations
These options are only for authorizing that the API can be used. Use with `c.auth` in your configure block

* `:bearer` - This option specifies a bearer token which requires a `c.token_model` option to be set.

```crystal
Kave.configure do |c|
  c.auth = :bearer
  c.token_model = MyCoolAuthToken
end
```

The `token_model` is a class that needs to inherit from `Kave::AuthToken`, and implement the class method `locate`. This `locate` class method should return a string that is your token.

## Development

This is going to be a work in progress for a while. If you have a better idea for how something should be implemented, please open an issue, or submit a PR.

## Contributing

1. Fork it ( https://github.com/jwoertink/kave/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Make sure all specs pass
5. Push to the branch (git push origin my-new-feature)
6. Create a new Pull Request

## Contributors

- [jwoertink(https://github.com/jwoertink) Jeremy Woertink - creator, maintainer
