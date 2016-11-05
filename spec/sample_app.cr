ENV["KEMAL_ENV"] = "test"

get "/" do
  "This is a public route"
end

api("v1") do
  get "/" do
    "This is a private route v1"
  end
end

api("v2") do
  get "/" do
    "This is a private route v2"
  end
end

Kemal.run
