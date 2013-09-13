module Greenhouse
  class API
    attr_accessor :api_token, :organization

    include HTTParty
    base_uri 'https://api.greenhouse.io/v1'

    def initialize(api_token = nil, default_options = {})
      @api_token = api_token || ENV['GREENHOUSE_API_TOKEN']
      @organization = default_options.delete(:organization)
    end

    def offices(options = {})
      get_response_hash("/boards/#{ query_organization(options) }/embed/offices")
    end

    def office(id, options = {})
      get_response_hash("/boards/#{ query_organization(options) }/embed/office?id=#{ id }")
    end

    def departments(options = {})
      get_response_hash("/boards/#{ query_organization(options) }/embed/departments")
    end

    def department(id, options = {})
      get_response_hash("/boards/#{ query_organization(options) }/embed/department?id=#{ id }")
    end

    def jobs(options = {})
      get_response_hash("/boards/#{ query_organization(options) }/embed/jobs")
    end

    def job(id, options = { :questions => false })
      get_response_hash("/boards/#{ query_organization(options) }/embed/job?id=#{ id }&questions=#{ options[:questions] }")
    end

    private

    def query_organization(options_hash)
      options_hash[:organization] || @organization
    end

    def get_response_hash(url)
      response = self.class.get(url)
      if response.code == 200
        MultiJson.load(response.body, :symbolize_keys => true)
      else
        Greenhouse::Error.new(response.code)
      end
    end

  end
end
