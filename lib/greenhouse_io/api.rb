module GreenhouseIo
  module API
    def get_response(url, options)
      @logger.info "Greenhouse GET #{url}" if @logger
      self.class.get(url, options)
    end

    def post_response(url, options)
      self.class.post(url, options)
    end

    def put_response(url, options)
      self.class.put(url, options)
    end

    def delete(url, options)
      self.class.delete(url, options)
    end

    def parse_json(response)
      Oj.load(response.body, mode: :compat, symbol_keys: GreenhouseIo.configuration.symbolize_keys)
    end

    def basic_auth
      { :username => self.api_token }
    end
  end
end
