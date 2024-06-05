require_relative '../request'

module GreenhouseIo
  module Offers
    include GreenhouseIo::Request

    def offers(id = nil, options = {})
      get_from_harvest_api "/offers#{path_id(id)}", options
    end

    def offers_for_application(id, options = {})
      get_from_harvest_api "/applications/#{id}/offers", options
    end

    def current_offer_for_application(id, options = {})
      get_from_harvest_api "/applications/#{id}/offers/current_offer", options
    end
  end
end
