module GreenhouseIo
  module Jobs

    def jobs(id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(id)}", options
    end

    def stages(id, options = {})
      get_from_harvest_api "/jobs#{path_id(id)}/stages", options
    end

    def job_post(id, options = {})
      get_from_harvest_api "/jobs#{path_id(id)}/job_post", options
    end
  end
end
