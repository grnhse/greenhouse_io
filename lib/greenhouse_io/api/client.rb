module GreenhouseIo
  class Client
    include HTTMultiParty
    include GreenhouseIo::API

    PERMITTED_OPTIONS = [:page, :per_page, :job_id]

    attr_accessor :api_token, :rate_limit, :rate_limit_remaining, :link
    base_uri 'https://harvest.greenhouse.io/v1'

    def initialize(api_token = nil)
      @api_token = api_token || GreenhouseIo.configuration.api_token
    end

    def offices(id = nil, options = {})
      get_from_harvest_api "/offices#{path_id(id)}", options
    end

    def departments(id = nil, options = {})
      get_from_harvest_api "/departments#{path_id(id)}", options
    end

    def applications(id = nil, options = {})
      get_from_harvest_api "/applications#{path_id(id)}", options
    end

    def scorecards(id, options = {})
      get_from_harvest_api "/applications/#{id}/scorecards", options
    end

    def all_scorecards(id = nil, options = {})
      get_from_harvest_api "/scorecards/#{id}", options
    end

    def scheduled_interviews(id, options = {})
      get_from_harvest_api "/applications/#{id}/scheduled_interviews", options
    end
  end
end

require_relative 'request'
require_relative 'modules/candidates'
require_relative 'modules/jobs'
require_relative 'modules/job_boards'
require_relative 'modules/offers'
# require_relative 'modules/applications'

module GreenhouseIo
  class Client
    # include GreenhouseIo::Applications
    include GreenhouseIo::Candidates
    include GreenhouseIo::JobBoards
    include GreenhouseIo::Jobs
    include GreenhouseIo::Offers
    include GreenhouseIo::Request

    attr_accessor :api_token, :rate_limit, :rate_limit_remaining, :link

    def initialize(api_token = nil)
      @api_token = api_token || GreenhouseIo.configuration.api_token
    end
  end
end
