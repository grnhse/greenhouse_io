require_relative '../request'

module GreenhouseIo
  module Jobs
    include GreenhouseIo::Request

    def jobs(id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(id)}", options
    end

    def stages(id, options = {})
      get_from_harvest_api "/jobs/#{id}/stages", options
    end

    def job_post(id, options = {})
      get_from_harvest_api "/jobs/#{id}/job_post", options
    end
  end
end
