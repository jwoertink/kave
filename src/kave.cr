require "./kave/*"
require "./kave/auth_strategy_handlers/*"
require "./kave/version_strategy_handlers/*"

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

# Defines the block of routes specific to this `version` api
def api(version : String)
  with Kave::ApiDSL.new(version) yield
end

# Defines the block of routes that are public
# and not bound to the API middleware stack
def public
  with Kave::PublicDSL.new yield
end
