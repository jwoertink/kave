ENV["KEMAL_ENV"] = "test"

Kave.configure do |c|
  c.strategy = :path
end

get "/" do
  "This is a public route"
end

Kave.get "/" do
  "This is a private route"
end

Kemal.run
