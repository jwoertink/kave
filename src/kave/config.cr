module Kave
  class Config
    getter auth_strategy, version_strategy
    property token_model, format, public_routes

    def initialize
      @auth_strategy = nil.as(Symbol?)
      @version_strategy = :path
      @token_model = Kave::AuthToken
      @format = :json
      @public_routes = Hash(String, Array(String)).new([] of String)
    end

    def auth_strategy=(option : Symbol)
      strategy = case option
                 when :bearer
                   add_handler(Kave::BearerHandler.new, 0)
                   :bearer
                 else
                   nil
                 end
      @auth_strategy = strategy
    end

    # This is used to decide how the API route will match
    #   curl http://localhost:3000/v1/test
    #       vs
    #   curl -H "Accept: application/vnd.api.v1+json" http://localhost:3000/test
    def version_strategy=(option : Symbol)
      strategy = case option
                 when :header
                   add_handler(Kave::HeaderVersionStrategyHandler.new, 0)
                   :header
                 else
                   :path
                 end

      @version_strategy = strategy
    end
  end
end
