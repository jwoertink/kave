module Kave
  class Config
    property strategy, auth, token_model, format

    def initialize
      @strategy = :path
      @auth = nil.as(Symbol | Nil)
      @token_model = Kave::AuthToken
      @format = :json
    end

  end
end
