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
  # c.format = :json                # see Formats below
  # c.auth_strategy = nil           # see Auth below
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

### Formats
The formats are how your data will be returned. By default, Kave will assume you're building a JSON API.
Kave will automatically set your response `Content-Type` to match the type of API you're building. 

For now, you must handle the data conversion yourself, but eventually Kave will take care of that for you. 

```crystal
# assumes format is :json
api("v1") do
  get "/users/:id" do |env|
    {"id" => env.params.url["id"], "name" => "jeremy"}.to_json
  end
end
```

You would make a call to this route by `http://localhost:3000/v1/users/1.json`

Additional options later will be `:xml`, `:msgpack`, `:plain`

### Auth Strategy
If your API isn't public, then you'll probably want to add some sort of API key. By default, Kave sets the `auth_strategy` to nil, but you can use a Bearer token authorization. To use this, set the `auth_strategy` to `:bearer`, and create a class that inherits from `Kave::AuthToken`. Set the `token_model` to your custom class, and make sure that class implements the class method `locate`.

```crystal
class MyTokenModel < Kave::AuthToken
  def self.locate(token : String)
    token == "abc123"
  end
end

Kave.configure do |c|
  c.auth_strategy = :bearer
  c.token_model = MyTokenModel
end

api("v1") do
  get "/users/:id" do |env|
    {"id" => env.params.url["id"], "name" => "jeremy"}.to_json
  end
end
```

To access this route:
```text
$ curl -H "AUTHORIZATION: Bearer abc123" "http://localhost:3000/v1/users/1.json"
```

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
