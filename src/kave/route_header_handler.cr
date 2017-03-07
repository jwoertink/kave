module Kave
  class RouteHeaderHandler < Kemal::Handler
    
    def call(context)
      if context.request.headers["Accept"]? &&
         context.request.headers["Accept"].match(Kave::ACCEPT_HEADER_REGEX)
        context.request.path = "/#{$1}#{context.request.path}"
      end
      call_next(context)
    end

  end
end
