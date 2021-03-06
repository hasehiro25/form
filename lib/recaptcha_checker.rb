# frozen_string_literal: true

class RecaptchaChecker
  RECAPTCHA_API_URL = "https://www.google.com/recaptcha/api/siteverify"

  def initialize(token:, registered_domain:)
    @token = token
    @registered_domain = registered_domain
  end

  def valid_token?
    res = JSON.load(fetch_api)
    res["success"] == true && res["hostname"] == registered_domain_wihtout_port
  end

  private
    def fetch_api
      url = URI.parse(RECAPTCHA_API_URL)
      body = {
        "secret": Settings.recaptcha_secret_key,
        "response": @token
      }
      res = Faraday.post(url, body)
      res.body
    end

    def registered_domain_wihtout_port
      @registered_domain.gsub(/:\d*/, "")
  end
end
