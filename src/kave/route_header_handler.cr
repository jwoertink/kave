module Kave
  class RouteHeaderHandler < Kemal::Handler
    
    def call(context)
      puts context.request.path

      call_next(context)
    end
  end
end
