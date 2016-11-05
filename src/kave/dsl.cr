module Kave
  class DSL
    property version
    
    def initialize(@version : String)
    end

    {% for method in %w(get post put patch delete) %}
      def {{method.id}}(path : String, &block : HTTP::Server::Context -> _)
        if Kave.configuration.strategy == :path
          path = ["/", version, path].join
        end

        Kemal::RouteHandler::INSTANCE.add_route({{method}}.upcase, path, &block)
      end
    {% end %}
  end
end
