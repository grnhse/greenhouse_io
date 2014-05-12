module GreenhouseIo
  module API
    def get_response(url, options)
      self.class.get(url, options)
    end

    def post_response(url, options)
      self.class.post(url, options)
    end

    def basic_auth
      { :username => self.api_token }
    end
  end
end
