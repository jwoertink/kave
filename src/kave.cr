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

  def self.reset_config!
    @@configuration = Config.new
  end
end

# Global scope
def api(version : String)
  with Kave::DSL.new(version) yield
end
