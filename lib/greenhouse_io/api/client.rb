module GreenhouseIo
  class Client
    include HTTMultiParty
    include GreenhouseIo::API

    PERMITTED_OPTIONS = [:page, :per_page]

    attr_accessor :api_token
    base_uri 'https://harvest.greenhouse.io/v1'

    def initialize(api_token = nil)
      @api_token = api_token || ENV['GREENHOUSE_API_TOKEN']
    end

    def offices(id = nil, options = {})
      get_response_hash "/offices#{path_id(id)}", permitted_options(options), basic_auth
    end

    def departments(id = nil, options = {})
      get_response_hash "/departments#{path_id(id)}", permitted_options(options), basic_auth
    end

    def candidates(id = nil, options = {})
      get_response_hash "/candidates#{path_id(id)}", permitted_options(options), basic_auth
    end

    def activity_feed(id, options = {})
      get_response_hash "/candidates/#{id}/activity_feed", permitted_options(options), basic_auth
    end

    def applications(id = nil, options = {})
      get_response_hash "/applications#{path_id(id)}", permitted_options(options), basic_auth
    end

    def scorecards(id, options = {})
      get_response_hash "/applications/#{id}/scorecards", permitted_options(options), basic_auth
    end

    def scheduled_interviews(id, options = {})
      get_response_hash "/applications/#{id}/scheduled_interviews", permitted_options(options), basic_auth
    end

    def jobs(id = nil, options = {})
      get_response_hash "/jobs#{path_id(id)}", permitted_options(options), basic_auth
    end

    def stages(id, options = {})
      get_response_hash "/jobs/#{id}/stages", permitted_options(options), basic_auth
    end

    def job_post(id, options = {})
      get_response_hash "/jobs/#{id}/job_post", permitted_options(options), basic_auth
    end

    def users(id = nil, options = {})
      get_response_hash "/users#{path_id(id)}", permitted_options(options), basic_auth
    end

    def sources(id = nil, options = {})
      get_response_hash "/sources#{path_id(id)}", permitted_options(options), basic_auth
    end

    private

    def path_id(id = nil)
      "/#{id}" unless id.nil?
    end

    def permitted_options(options)
      options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end
  end
end
