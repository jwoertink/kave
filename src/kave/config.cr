module Kave
  class Config
    getter auth_strategy
    property token_model, format, public_routes

    def initialize
      @auth_strategy = nil.as(Symbol?)
      @token_model = Kave::AuthToken
      @format = :json
      @public_routes = [] of String
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

    # This is used to decide how the API route will match
    #   curl http://localhost:3000/v1/test
    #       vs
    #   curl -H "Accept: application/vnd.api.v1+json" http://localhost:3000/test
    def path_option=(option : String?)
      if option == "header"
        add_handler Kave::RouteHeaderHandler.new
      end
    end
  end
end
