module GreenhouseIo
  module API
    def get_response_hash(url)
      response = self.class.get(url)
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
