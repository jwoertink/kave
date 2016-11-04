module Kave
  class Config
    property strategy

    def initialize
      @strategy = :bearer
    end

  end
end
