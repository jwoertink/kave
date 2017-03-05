module Kave
  abstract class AuthToken
    
    # If "truthy" then the token has been found.
    abstract def self.locate(token : String)
  end
end
