require "usda_fdc/version"
require "usda_fdc/ApiExceptions"
require "usda_fdc/HttpStatusCodes"

module UsdaFdc
  class Error < StandardError; end
  class Client
    include HttpStatusCodes
    include ApiExceptions

    require 'oj'
    require 'faraday'
    require 'json'

    API_ENDPOINT = 'https://api.nal.usda.gov/fdc/v1'

    attr_reader :api_key

    def initialize(api_key)
      @api_key = api_key
    end

    def search(search_term, options = {})
      options["generalSearchInput"] = search_term unless options.key?("generalSearchInput")
      request(
        http_method: :post,
        endpoint: "search?api_key=#{@api_key}",
        params: options.to_json
      )
    end

    def details(food_fdc_num)
      request(
        http_method: :get,
        endpoint: "#{food_fdc_num}?api_key=#{api_key}"
      )
    end

    private

    def client
      @_client ||= Faraday.new(API_ENDPOINT, :headers => {"Content_Type": 'application/json'}) do |client|
        client.adapter Faraday.default_adapter
      end
    end

    def request(http_method:, endpoint:, params: {})
      response = client.public_send(http_method, endpoint, params)
      parsed_response = Oj.load(response.body)

      return parsed_response if response.status == HTTP_OK_CODE
      raise error_class, "Code: #{response.status}, response: #{response.body}"
    end

    def error_class
      case response.status
      when HTTP_BAD_REQUEST_CODE
        BadRequestError
      when HTTP_UNAUTHORIZED_CODE
        UnauthorizedError
      when HTTP_FORBIDDEN_CODE
        return ApiRequestsQuotaReachedError if api_requests_quota_reached?
        ForbiddenError
      when HTTP_NOT_FOUND_CODE
        NotFoundError
      when HTTP_UNPROCESSABLE_ENTITY_CODE
        UnprocessableEntityError
      else
        ApiError
      end
    end

    # this broke after moving HttpStatusCodes & ApiExceptions to external modules
    # def response_successful?
    #   response.status == HTTP_OK_CODE
    # end

    def api_requests_quota_reached?
      response.body.match?(API_REQUESTS_QUOTA_REACHED_MESSAGE)
    end
  end
end
