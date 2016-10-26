# @private
module FaradayMiddleware
  # @private
  class RaiseHttpException < Faraday::Middleware
    def call(env)
      @app.call(env).on_complete do |response|
        case response[:status].to_i
        when 400
          raise PrintNode::BadRequest, error_message_400(response)
        when 404
          raise PrintNode::NotFound, error_message_400(response)
        when 500
          raise PrintNode::InternalServerError, error_message_500(response, "Something is technically wrong.")
        when 502
          raise PrintNode::BadGateway, error_message_500(response, "The server returned an invalid or incomplete response.")
        when 503
          raise PrintNode::ServiceUnavailable, error_message_500(response, "Print Node is rate limiting your requests.")
        when 504
          raise PrintNode::GatewayTimeout, error_message_500(response, "504 Gateway Time-out")
        end
      end
    end

    def initialize(app)
      super app
      @parser = nil
    end

    private

    def error_message_400(response)
      "#{response[:method].to_s.upcase} #{response[:url].to_s} status: #{response[:status]}#{error_body(response[:body])}"
    end

    def error_body(body)
      # body gets passed as a string, not sure if it is passed as something else from other spots?
      if not body.nil? and not body.empty? and body.kind_of?(String)
        body = ::JSON.parse(body)
      end

      if body.nil? || body['errors'].nil?
        nil
      else
        body_errors = body['errors'].flat_map {|error| error.map {|k,v| "#{k}: #{v}" }}.compact.join(', ')
        " - #{body_errors}"
      end
    end

    def error_message_500(response, body=nil)
      "#{response[:method].to_s.upcase} #{response[:url].to_s} status: #{[response[:status].to_s + ':', body].compact.join(' ')}"
    end
  end
end

module PrintNode
  # Custom error class for rescuing from all Print Node errors
  class Error < StandardError; end

  # Raised when Print Node returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Print Node returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Print Node returns the HTTP status code 429
  class TooManyRequests < Error; end

  # Raised when Print Node returns the HTTP status code 500
  class InternalServerError < Error; end

  # Raised when Print Node returns the HTTP status code 502
  class BadGateway < Error; end

  # Raised when Print Node returns the HTTP status code 503
  class ServiceUnavailable < Error; end

  # Raised when Print Node returns the HTTP status code 504
  class GatewayTimeout < Error; end

end