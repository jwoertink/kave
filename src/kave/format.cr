module Kave
  class Format
    MAPPING = {json: json}
    
    def self.json
      {"content_type" => "application/json", "extension" => ".json"}
    end
  end
end
