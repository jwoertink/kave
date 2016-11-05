ENV["KEMAL_ENV"] = "test"

get "/" do
  "This is a public route"
end

Kave.get "/" do
  "This is a private route"
end

Kemal.run
