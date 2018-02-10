module Kave
  class ApiDSL
    property version

    def initialize(@version : String)
      # Setup before block content_type
      Kemal::FilterHandler::INSTANCE.before("ALL", "*") do |env|
        env.response.content_type = Kave::Format::MAPPING[Kave.configuration.format]["content_type"]
      end
    end

    # Copy the same DSL Kemal provides for inside of the API block
    {% for method in HTTP_METHODS %}
      def {{method.id}}(path : String, &block : HTTP::Server::Context -> _)
        path = api_route_for_path(path)
        Kemal::RouteHandler::INSTANCE.add_route({{method}}.upcase, path, &block)
      end
    {% end %}

    {% for type in ["before", "after"] %}
      {% for method in FILTER_METHODS %}
        def {{type.id}}_{{method.id}}(path = "*", &block : HTTP::Server::Context -> _)
          path = api_route_for_path(path)
          Kemal::FilterHandler::INSTANCE.{{type.id}}({{method}}.upcase, path, &block)
        end
      {% end %}
    {% end %}

    # Prepends the api version and appends the extension for the path
    # `/users` => `/v1/users.json`
    private def api_route_for_path(path)
      extension = Kave::Format::MAPPING[Kave.configuration.format]["extension"]
      path = ["/", version, path, extension].join
      path
    end
  end
end
