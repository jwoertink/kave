module Kave
  class BearerHandler < HTTP::Handler
    BEARER = "Bearer"
    AUTH = "AUTHORIZATION"
    AUTH_MESSAGE = "Unauthorized"
    HEADER_LOGIN_REQUIRED = "Bearer realm=\"Authentication required\""
    def call(context)
      if context.request.headers[AUTH]?
        context.request.headers[AUTH].match(/#{BEARER}\s(\w+)$/)
        if $1? && authorized?($1?)
          call_next(context)
        end
      end

      context.response.status_code = 401
      context.response.headers["WWW-Authenticate"] = HEADER_LOGIN_REQUIRED
    end

    def authorized?(token)
      Kave.configuration.token_model.locate(token.to_s)
    end
  end
end
