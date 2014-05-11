module GreenhouseIo
  module API
    def get_response_hash(url, query = nil, basic_auth = nil)
      response = self.class.get(url, query: query, basic_auth: basic_auth)
      if response.code == 200
        MultiJson.load(response.body, :symbolize_keys => true)
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end

    def basic_auth
      { :username => self.api_token }
    end
  end
end
