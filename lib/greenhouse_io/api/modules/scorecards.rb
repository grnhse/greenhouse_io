module GreenhouseIo
  module Scorecards

    def scorecards(application_id, options = {})
      paginated_get("/applications#{path_id(application_id)}/scorecards", options, 'scorecards')
    end

    def scorecard(id = nil, options = {})
      get_from_harvest_api "/scorecards/#{path_id(id)}", options
    end
  end
end
