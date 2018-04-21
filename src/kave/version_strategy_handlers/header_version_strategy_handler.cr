module Kave
  class HeaderVersionStrategyHandler < Kemal::Handler

    def call(context)
      if Kave.configuration.public_routes[context.request.method.upcase].includes?(context.request.path) && !(context.request.headers["Accept"]? && context.request.headers["Accept"].match(Kave::ACCEPT_HEADER_REGEX))
        return call_next(context)
      end
      if context.request.headers["Accept"]? &&
         context.request.headers["Accept"].match(Kave::ACCEPT_HEADER_REGEX)
        path = "/#{$1}#{context.request.path}"
        result = path.match(/(\.\w+)/) # Match patterns like .json
        path = path.gsub($1, "") if result && $1 == Kave::Format::MAPPING[Kave.configuration.format]["extension"]
        context.request.path = path
        call_next(context)
      else  
        context.response.status_code = 400
        context.response.print "Bad Request"
      end
    end
  end
end
