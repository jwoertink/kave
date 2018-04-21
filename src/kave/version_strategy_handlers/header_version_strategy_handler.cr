module Kave
  class HeaderVersionStrategyHandler < Kemal::Handler
    exclude Kave.configuration.public_routes["GET"], "GET"
    exclude Kave.configuration.public_routes["POST"], "POST"

    def call(context)
      return call_next(context) if exclude_match?(context)
      if context.request.headers["Accept"]? &&
         context.request.headers["Accept"].match(Kave::ACCEPT_HEADER_REGEX)
        path = "/#{$1}#{context.request.path}"
        path.match(/(\.\w+)/) # Match patterns like .json
        path = path.gsub($1, "") if $1 && $1 == Kave::Format::MAPPING[Kave.configuration.format]["extension"]
        context.request.path = path
      end
      call_next(context)
    end
  end
end
