require "faraday"

class SmsUslugiApi

  def initialize(username, password)
    @username = username
    @password = password
    @api = Faraday.new(url: "https://lcab.sms-uslugi.ru/lcabApi") do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
    end
  end

end
