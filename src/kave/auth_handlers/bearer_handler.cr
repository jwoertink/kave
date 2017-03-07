module Kave
  class BearerHandler < Kemal::Handler
    AUTH = "Authorization"
    AUTH_MESSAGE = "Unauthorized"
    HEADER_LOGIN_REQUIRED = "Bearer realm=\"Authentication required\""
    
    def call(context)
      return call_next(context) if Kave.configuration.public_routes.includes?(context.request.path)
      if header = context.request.headers[AUTH]?
        matched = header.match(/Bearer\s(\w+)$/)
        if matched && $1 && authorized?($1)
          return call_next(context)
        end
      end

      context.response.status_code = 401
      context.response.headers["WWW-Authenticate"] = HEADER_LOGIN_REQUIRED
      context.response.print AUTH_MESSAGE 
    end

    def authorized?(token)
      Kave.configuration.token_model.locate(token.to_s)
    end
  end
end
