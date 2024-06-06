module GreenhouseIo
  module Applications

    def applications(options = {})
      paginated_get("/applications", options, 'applications')
    end

    def application(id = nil, options = {})
      p "loading application path: /applications#{path_id(id)}"
      get_from_harvest_api("/applications#{path_id(id)}", options)
    end

    # delete applications
    # DELETE https://harvest.greenhouse.io/v1/applications/{id}

    # add application to candidate/prospect
    # POST https://harvest.greenhouse.io/v1/candidates/{id}/applications

    # convert prospect to candidate
    # PATCH https://harvest.greenhouse.io/v1/applications/{id}/convert_prospect

    # update applications
    # PATCH https://harvest.greenhouse.io/v1/applications/{id}
  end
end
