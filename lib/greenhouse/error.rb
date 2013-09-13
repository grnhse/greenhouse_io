module Greenhouse
  class Error < StandardError
    attr_reader :code

    def initialize(code)
      @code = code
    end

    def inspect
      "Greenhouse::Error #{ @code } RESPONSE"
    end

    def message
      "An error has occured. Error Code: #{ @code }"
    end
  end
end
