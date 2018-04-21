ENV["KEMAL_ENV"] = "test"

error 404 do
  "This page is missing"
end

public do
  get "/users" do
    "This is a public route"
  end
end

api("v1") do
  get "/users" do
    "This is a private route v1"
  end

  get "/users/:id" do |env|
    "This is users #{env.params.url["id"]}"
  end

  post "/users/:id/articles" do |env|
    {"id" => env.params.url["id"]}.to_json
  end
end

api("v2") do
  get "/users" do
    "This is a private route v2"
  end
end

