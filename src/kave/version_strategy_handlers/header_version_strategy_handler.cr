module Kave
  class HeaderVersionStrategyHandler < Kemal::Handler
    exclude Kave.configuration.public_routes["GET"], "GET"
    exclude Kave.configuration.public_routes["POST"], "POST"

    def call(context)
      return call_next(context) if exclude_match?(context)
      if context.request.headers["Accept"]? &&
         context.request.headers["Accept"].match(Kave::ACCEPT_HEADER_REGEX)
        context.request.path = "/#{$1}#{context.request.path}"
      end
      call_next(context)
    end
  end
end
