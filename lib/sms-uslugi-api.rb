require "faraday"
require "json"

class SmsUslugiApi

  BASE_API_URL = "https://lcab.sms-uslugi.ru/lcabApi"

  def initialize(username, password)
    @username = username
    @password = password
    @api = Faraday.new
  end

  def info
    api_request("info.php")
  end

  private

  def api_request(url, method = :get)
    url = "#{BASE_API_URL}/#{url}"
    if method == :post
      JSON::parse @api.post(url, login: @username, password: @password).body, symbolize_names: true
    else
      JSON::parse @api.get(url, login: @username, password: @password).body, symbolize_names: true
    end
  end

end
