module Kave
  abstract class AuthToken
    # If "truthy" then the token has been found.
    def self.locate(token : String)
      true
    end
  end
end
