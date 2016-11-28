module Kave
  class BearerHandler < HTTP::Handler
    BEARER = "Bearer"
    AUTH = "Authorization"
    AUTH_MESSAGE = "Unauthorized"
    HEADER_LOGIN_REQUIRED = "Bearer realm=\"Authentication required\""
    def call(context)
      if header = context.request.headers[AUTH]?
        matched = header.match(/#{BEARER}\s(\w+)$/)
        if matched && $1 && authorized?($1)
          return call_next(context)
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
