module Kave
  class RouteHeaderHandler < Kemal::Handler

    def initialize(@dsl : Kave::DSL)
    end
   
    def call(context)
      if @dsl.use_header
        puts "\n\nUSING HEADER: #{@dsl.version}"
        puts "REQUEST: #{context.request.path}\n\n"
        #process_context(context)
      end
      call_next(context)
    end

    private def process_context(context)
      if context.request.headers["Accept"] &&
         context.request.headers["Accept"].match(Kave::ACCEPT_HEADER_REGEX) &&
         $1 == @dsl.version
        context.request.path = "/#{$1}#{context.request.path}"
      else
        context.response.status_code = 404
      end
    end
  end
end
