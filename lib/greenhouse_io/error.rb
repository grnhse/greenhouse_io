module GreenhouseIo
  class Error < StandardError
    attr_reader :msg, :code

    def initialize(msg = nil, code = nil)
      @msg = msg
      @code = code
    end

    def inspect
      if @code
        "GreenhouseIo::Error: #{ @code } response from server"
      else
        "GreenhouseIo::Error: #{ @msg }"
      end
    end

    def message
      @msg
    end
  end
end
