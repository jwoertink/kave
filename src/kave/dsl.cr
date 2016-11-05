module Kave
  class DSL
    @@stored_routes = [] of Tuple(String, String)
    
    def self.add_route(http_method : String, path : String, &block : HTTP::Server::Context -> _)
      @@stored_routes << {http_method, path}
      case Kave.configuration.strategy
      when :path
        path = ["/", "v#{Kave.configuration.current_version}", path].join
      end

      Kemal::RouteHandler::INSTANCE.add_route(http_method, path, &block)
    end
  end
end
