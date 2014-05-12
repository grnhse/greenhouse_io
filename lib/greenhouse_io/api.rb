module GreenhouseIo
  module API
    def get_response(url, options)
      self.class.get(url, options)
    end

    def post_response(url, options)
      self.class.post(url, options)
    end

    def parse_json(response)
      MultiJson.load(response.body, symbolize_keys: GreenhouseIo.configuration.symbolize_keys)
    end

    def basic_auth
      { :username => self.api_token }
    end
  end
end
