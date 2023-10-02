module BlSecurityAddons
  module Gatekeeper
    def gatekeeper
      return if gatekeeper_special_case
      if Rails.application.credentials.dig(
           Rails.env.to_sym,
           :jwt_security_enabled
         )
        check_jwt
      end
      if Rails.application.credentials.dig(
           Rails.env.to_sym,
           :req_url_whitelisted_enabled
         )
        req_url_whitelisted?
      end
    end
  
    def gatekeeper_special_case
      auth_headers = request.headers["Authorization"]
      gql_enabled_keys =
        Rails.application.credentials.dig(Rails.env.to_sym, :gql_enabled_keys)
      if auth_headers.present? && gql_enabled_keys.include?(auth_headers)
        true
      else
        false
      end
    end
  
    def req_url_whitelisted?
      whitelisted_urls =
        Rails
          .application
          .credentials
          .dig(Rails.env.to_sym, :whitelisted_consumer_urls)
          .split(";")
      head :forbidden if whitelisted_urls.exclude?(request.original_url)
    end
  
    def check_jwt
      begin
        options = { algorithm: "HS256" }
        auth_header = request.headers["Authorization"]
        head :forbidden && return unless auth_header.present?
        bearer = auth_header.slice(7..-1)
        jwt_allowed_keys =
          Rails.application.credentials.dig(Rails.env.to_sym, :jwt_allowed_keys)
        payload, header =
          JWT.decode bearer,
                     Rails.application.credentials.dig(
                       Rails.env.to_sym,
                       :jwt_secret
                     ),
                     false,
                     options
        iss = payload["iss"]
        head :forbidden unless jwt_allowed_keys.include?(iss)
      rescue JWT::DecodeError
        head :unauthorized
      rescue JWT::ExpiredSignature
        head :forbidden
      rescue JWT::InvalidIssuerError
        head :forbidden
      rescue JWT::InvalidIatError
        head :forbidden
      end
    end
  end
end