module Kave
  class PublicDSL
    
    {% for method in %w(get post put patch delete options) %}
      def {{method.id}}(path : String, &block : HTTP::Server::Context -> _)
        Kave.configuration.public_routes[{{method}}.upcase] ||= [] of String
        Kave.configuration.public_routes[{{method}}.upcase].push(path)

        # Kemal already defined this method. Just call that
        ::{{method.id}}(path, &block)
      end
    {% end %}
  end
end
