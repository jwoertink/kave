module Kave
  class Config
    property strategy, token_model, current_version

    def initialize
      @strategy = :bearer
      @token_model = Kave::AuthToken
      @current_version = 1
    end

  end
end
