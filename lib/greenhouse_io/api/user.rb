module GreenhouseIo
  class User
    include HTTParty
    include GreenhouseIo::API
    attr_accessor :api_token

    base_uri 'https://api.greenhouse.io/v1/partner'

    def initialize(api_token = nil)
      @api_token = api_token
    end

    def candidates(ids)
      url = "/candidates?candidate_ids=#{ids.join(",")}"
      get_from_ingestion_api url
    end

    def current_user
      get_from_ingestion_api "/current_user"
    end

    def jobs
      get_from_ingestion_api "/jobs"
    end

    def push_candidate(body)
      post_to_ingestion_api("/candidates", body)
    end

    private

    def get_from_ingestion_api(url)
      response = get_response(url, headers: api_auth_header)

      if response.code == 200
        parse_json(response)
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end

    def post_to_ingestion_api(url, body)
      response = post_response(url, {
          body: body,
          headers: api_auth_header
      })

      if response.code == 200
        parse_json(response)
      else
        raise GreenhouseIo::Error.new(response.code)
      end
    end
  end
end

