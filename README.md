# Kave (Kemal API Version Extension)

This shards makes it easier to version your [Kemal](http://kemalcr.com/) API

**WARNING:** experimental stage. Things are working, but may change often

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
  # These are default config options
  # c.strategy = :path              # see Strategies below
  # c.format = :json                # see Formats below
  # c.auth = nil                    # see Auth below
  # c.token_model = Kave::AuthToken # see Auth below
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
  # Your config options go here
  # possible options
  # * strategy - This is how we look up which route you want
  # * format - This is the format your data is returned in the API
  # * auth - Authorization for the API
  # * token_model - The class that will validate the Authorization
end

# Return your Kave config options for later use
Kave.configuration.strategy #=> :path
```

### Strategies
These are the strategies that you use to query your API routes.

By default Kave will use a `:path` strategy where all of your routes are prepended with the version.

```crystal
# assumes stratgy is :path
api("v1") do
  get "/users" do |env|
    [{"id" => 1, "name" => "Jeremy"}]
  end
end
```

You would make a call to this route by `http://localhost:3000/v1/users.json`

Additional options later will be `:header`

### Formats
The formats are how your data will be returned. By default, Kave will assume you're building a JSON API.
Kave will automatically set your response `Content-Type` to match the type of API you're building. As well as add the appropriate conversion for the blocks so you don't have to type it on every route.

```crystal
# assumes format is :json
api("v1") do
  get "/users/:id" do |env|
    # Kave will call .to_json on this thing, so it must responds_to?(:to_json)
    {"id" => env.params.url["id"], "name" => "jeremy"}
  end
end
```

You would make a call to this route by `http://localhost:3000/v1/users/1.json`

Additional options later will be `:xml`, `:msgpack`, `:plain`

### Auth

Not really implemented yet..

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
