module Kave
  class DSL
    property version 
    property stored_routes = [] of Tuple(String, String)
    property use_header : Bool?
    
    def initialize(@version : String)
      # TODO: This probably needs to be somewhere better
      add_handler Kave::RouteHeaderHandler.new(self)
      
      # Setup before block content_type
      Kemal::FilterHandler::INSTANCE.before("ALL", "*") do |env| 
        env.response.content_type = Kave::Format::MAPPING[Kave.configuration.format]["content_type"]
      end
    end

    def initialize(@version : String, header_options : Hash(String, String))
      @use_header = header_options["path_option"] == "use_header"
      initialize(@version)
    end

    # Copy the same DSL Kemal provides for inside of the API block
    {% for method in %w(get post put patch delete) %}
      def {{method.id}}(path : String, &block : HTTP::Server::Context -> _)
        extension = Kave::Format::MAPPING[Kave.configuration.format]["extension"]
        path = ["/", version, path, extension].join
        @stored_routes << {path, {{method}}}
      
        Kemal::RouteHandler::INSTANCE.add_route({{method}}.upcase, path, &block)
      end
    {% end %}
  end
end
