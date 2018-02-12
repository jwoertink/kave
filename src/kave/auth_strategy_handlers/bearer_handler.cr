module Kave
  class BearerHandler < Kemal::Handler
    AUTH                  = "Authorization"
    AUTH_MESSAGE          = "Unauthorized"
    HEADER_LOGIN_REQUIRED = "Bearer realm=\"Authentication required\""

    # Faking the Kemal exclude handler since that runs in a macro and would be empty.
    # If there's a public route found, just pass through
    # If there's an Authorization header, and the token is found, then pass through
    # Otherwise return a 401 if the route is defined or 404 and move on
    def call(context)
      if Kave.configuration.public_routes[context.request.method.upcase].includes?(context.request.path)
        return call_next(context)
      end

      if header = context.request.headers[AUTH]?
        matched = header.match(/Bearer\s(\w+)$/)
        if matched && $1 && authorized?($1)
          return call_next(context)
        end
      end

      if context.route_defined?
        context.response.status_code = 401
        context.response.headers["WWW-Authenticate"] = HEADER_LOGIN_REQUIRED
        context.response.print AUTH_MESSAGE
      else
        context.response.status_code = 404
        call_next(context)
      end
    end

    def authorized?(token)
      Kave.configuration.token_model.locate(token.to_s)
    end
  end
end
