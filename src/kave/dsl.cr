module Kave
  class DSL
    property version, stored_routes
    
    def initialize(@version : String, @stored_routes = [] of Tuple(String, String))
    end

    # thoughts: Kemal can't store 2 routes that look the same
    # This works because the routes are actually different
    #   /v1/users 
    #   /v2/users
    #
    # This fails because they look the same
    #   /users
    #   /users
    # If the second way is using headers, then I should see if I can modify the request
    # A request to /users with API v1 could lookup /v1/users but without any 30X redirect
    # This may be possible because the Radix::Tree doesn't care what the route looks like...
    # I just need to override the lookup https://github.com/sdogruyol/kemal/blob/master/src/kemal/route_handler.cr#L27
    {% for method in %w(get post put patch delete) %}
      def {{method.id}}(path : String, &block : HTTP::Server::Context -> _)
        @stored_routes << {path, {{method}}}
        if Kave.configuration.strategy == :path
          path = ["/", version, path].join
        end

        Kemal::RouteHandler::INSTANCE.add_route({{method}}.upcase, path, &block)
      end
    {% end %}
  end
end
