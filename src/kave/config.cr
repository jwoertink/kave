module Kave
  class Config
    getter auth_strategy
    property token_model, format

    def initialize
      @auth_strategy = nil.as(Symbol?)
      @token_model = Kave::AuthToken
      @format = :json
    end

    def auth_strategy=(new_strategy : Symbol)
      strategy = case new_strategy
      when :bearer
        add_handler Kave::BearerHandler.new
        :bearer
      else
        nil
      end
      @auth_strategy = strategy
    end

  end
end
