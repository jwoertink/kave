require "./kave/*"
require "./kave/auth_handlers/*"

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

def api(version : String, header_options : Hash(String, String))
  with Kave::DSL.new(version, header_options) yield
end
