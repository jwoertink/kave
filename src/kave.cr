require "./kave/*"

module Kave
  @@configuration = Config.new

  def self.configure
    yield(@@configuration)
    @@configuration
  end

  def self.configuration
    @@configuration
  end

  def self.get(path, &block : HTTP::Server::Context -> _)
    Kave::DSL.add_route("GET", path, &block)
  end
end
