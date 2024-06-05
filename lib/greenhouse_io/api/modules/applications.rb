require_relative '../request'

module GreenhouseIo
  module Applications
    include GreenhouseIo::Request

    # list applications
    # GET https://harvest.greenhouse.io/v1/applications

    # get application
    # GET https://harvest.greenhouse.io/v1/applications/{id}

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

