require "./kave/*"
require "./kave/auth_handlers/*"

module Kave
  # TODO: allow other formats like xml, etc...
  ACCEPT_HEADER_REGEX = /\Aapplication\/vnd\.api\.(v([0-9]))?\+json\z/
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
  Kave.configuration.path_option = header_options["path"]?
  with Kave::DSL.new(version) yield
end
