module Greenhouse
  class Error < StandardError
    attr_reader :msg, :code

    def initialize(msg = nil, code = nil)
      @msg = msg
      @code = code
    end

    def inspect
      if @code
        "Greenhouse::Error: #{ @code } response from server"
      else
        "Greenhouse::Error: #{ @msg }"
      end
    end

    def message
      @msg
    end
  end
end
