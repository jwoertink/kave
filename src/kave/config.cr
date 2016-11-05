module Kave
  class Config
    property strategy, token_model

    def initialize
      @strategy = :bearer
      @token_model = Kave::AuthToken
    end

  end
end
