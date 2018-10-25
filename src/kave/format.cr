module Kave
  class Format
    MAPPING = {json: json, msgpack: msgpack}

    def self.json
      {"content_type" => "application/json", "extension" => ".json"}
    end

    def self.msgpack
      {"content_type" => "application/msgpack"}
    end

    def jsonize(obj)
      case obj
      when Array
        obj.map { |o| jsonize(o) }.as(JSON::Type)
      when Hash
        h = {} of String => JSON::Type
        obj.each { |k, v| h[k] = jsonize(v) }
        h.as(JSON::Type)
      when Int32
        obj.to_i64.as(JSON::Type)
      else
        obj.as(JSON::Type)
      end
    end
  end
end
