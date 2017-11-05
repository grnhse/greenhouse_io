module GreenhouseIo
  class Client
    include HTTMultiParty
    include GreenhouseIo::API

    PERMITTED_OPTIONS = [:page, :per_page, :job_id, :created_before, :created_after, :updated_after, :updated_before, :last_activity_after, :status ]

    attr_accessor :api_token, :rate_limit, :rate_limit_remaining, :link, :logger
    base_uri 'https://harvest.greenhouse.io/v1'

    def initialize(api_token = nil)
      @api_token = api_token || GreenhouseIo.configuration.api_token
    end

    def offices(id = nil, options = {})
      get_from_harvest_api "/offices#{path_id(id)}", options
    end

    def rejection_reasons(id = nil, options = {})
      get_from_harvest_api "/rejection_reasons#{path_id(id)}", options
    end

    def email_templates(id = nil, options = {})
      get_from_harvest_api "/email_templates#{path_id(id)}", options
    end

    def offers(id = nil, options = {})
      get_from_harvest_api "/offers#{path_id(id)}", options
    end

    def departments(id = nil, options = {})
      get_from_harvest_api "/departments#{path_id(id)}", options
    end

    def candidates(id = nil, options = {})
      get_from_harvest_api "/candidates#{path_id(id)}", options
    end

    def activity_feed(id, options = {})
      get_from_harvest_api "/candidates/#{id}/activity_feed", options
    end

    def create_candidate_note(candidate_id, note_hash, on_behalf_of)
      post_to_harvest_api(
        "/candidates/#{candidate_id}/activity_feed/notes",
        note_hash,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def move_job_application(application_id, from_stage_id, to_stage_id, on_behalf_of)
      post_to_harvest_api(
        "/applications/#{application_id}/move", {
          from_stage_id: from_stage_id,
          to_stage_id: to_stage_id
        },
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def reject_job_application(application_id, on_behalf_of, rejection_email_id: nil,
                               send_email_at: nil, notes: nil, rejection_reason_id: nil)
      params = {}
      params[:rejection_reason_id] = rejection_reason_id if rejection_reason_id
      params[:notes] = notes if notes.present?
      if rejection_email_id
        params[:rejection_email] = {
          email_template_id: rejection_email_id,
        }
        if send_email_at
          params[:rejection_email][:send_email_at] = send_email_at.utc.iso8601
        end
      end

      post_to_harvest_api(
        "/applications/#{application_id}/reject",
        params,
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def transfer_job_application(application_id, to_job_id, on_behalf_of, to_stage_id: nil)
      post_to_harvest_api(
        "/applications/#{application_id}/transfer_to_job", {
          new_job_id: to_job_id,
          new_stage_id: to_stage_id
        },
        { 'On-Behalf-Of' => on_behalf_of.to_s }
      )
    end

    def applications(id = nil, options = {})
      get_from_harvest_api "/applications#{path_id(id)}", options
    end

    def offers_for_application(id, options = {})
      get_from_harvest_api "/applications/#{id}/offers", options
    end

    def current_offer_for_application(id, options = {})
      get_from_harvest_api "/applications/#{id}/offers/current_offer", options
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

    def all_scheduled_interviews(id = nil, options = {})
      get_from_harvest_api "/scheduled_interviews/#{id}", options
    end

    def jobs(id = nil, options = {})
      get_from_harvest_api "/jobs#{path_id(id)}", options
    end

    def stages(id = nil, options = {})
      if id.present?
        get_from_harvest_api "/jobs/#{id}/stages", options
      else
        get_from_harvest_api "/job_stages", options
      end
    end

    def job_post(id, options = {})
      get_from_harvest_api "/jobs/#{id}/job_post", options
    end

    def users(id = nil, options = {})
      get_from_harvest_api "/users#{path_id(id)}", options
    end

    def sources(id = nil, options = {})
      get_from_harvest_api "/sources#{path_id(id)}", options
    end

    private

    def path_id(id = nil)
      "/#{id}" unless id.nil?
    end

    def permitted_options(options)
      options
      #options.select { |key, value| PERMITTED_OPTIONS.include? key }
    end

    def get_from_harvest_api(url, options = {})
      parse_response = options.fetch(:parse_response, true)

      httparty_options = {
        :query => permitted_options(options),
        :basic_auth => basic_auth,
      }
      response = get_response(url, httparty_options)

      set_headers_info(response.headers)

      if (200..299).include?(response.code)
        if parse_response
          parse_json(response)
        else
          response
        end
      else
        raise GreenhouseIo::Error.new(response, response.code)
      end
    end

    def post_to_harvest_api(url, body, headers)
      response = post_response(url, {
        :body => JSON.dump(body),
        :basic_auth => basic_auth,
        :headers => headers
      })

      set_headers_info(response.headers)

      if (200..299).include?(response.code)
        parse_json(response)
      else
        raise GreenhouseIo::Error.new(response, response.code)
      end
    end

    def set_headers_info(headers)
      self.rate_limit = headers['x-ratelimit-limit'].to_i
      self.rate_limit_remaining = headers['x-ratelimit-remaining'].to_i
      self.link = headers['link'].to_s
    end
  end
end
