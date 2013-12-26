module Greenhouse
  class API
    attr_accessor :api_token, :organization

    include HTTMultiParty
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
      get_response_hash("/boards/#{ query_organization(options) }/embed/jobs?content=#{ options[:content] }")
    end

    def job(id, options = { :questions => false })
      get_response_hash("/boards/#{ query_organization(options) }/embed/job?id=#{ id }&questions=#{ options[:questions] }")
    end

    def apply_to_job(job_form_hash)
      options = { :body => job_form_hash, :basic_auth => basic_auth }
      post_response_hash('/applications', options)
    end

    private

    def query_organization(options_hash)
      org = options_hash[:organization] || @organization
      org.nil? ? (raise Greenhouse::Error.new("organization can't be blank")) : org
    end

    def get_response_hash(url)
      response = self.class.get(url)
      if response.code == 200
        MultiJson.load(response.body, :symbolize_keys => true)
      else
        raise Greenhouse::Error.new(response.code)
      end
    end

    def post_response_hash(url, options)
      response = self.class.post(url, options)
      if response.code == 200
        response.include?("success") ? MultiJson.load(response.body, :symbolize_keys => true) : raise(Greenhouse::Error.new(response["reason"]))
      else
        raise Greenhouse::Error.new(response.code)
      end
    end

    def basic_auth
      { :username => @api_token }
    end

  end
end
