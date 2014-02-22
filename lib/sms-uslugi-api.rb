require "faraday"
require "json"

class SmsUslugiApi

  BASE_API_URL = "https://lcab.sms-uslugi.ru/lcabApi"

  def initialize(username, password)
    @username = username
    @password = password
    @api = Faraday.new
  end

  # https://lcab.sms-uslugi.ru/integration/lcabApi#main/Другое/orgInfo
  def info
    api_request("info.php")
  end

  # https://lcab.sms-uslugi.ru/integration/lcabApi#main/pager/send
  # txt must be in UTF-8 encoding!
  def send(txt, to, idGroup = nil, source = nil, flash = 0, dateTimeSend = nil, onlydelivery = 0, use_alfasource = nil, discountID = nil)
    api_request("sendSms.php", {
      txt: txt,
      to: to,
      idGroup: idGroup,
      source: source,
      flash: flash,
      dateTimeSend: dateTimeSend,
      onlydelivery: onlydelivery,
      use_alfasource: use_alfasource,
      discountID: discountID
    })
  end

  private

  def api_request(url, options = {})
    url = "#{BASE_API_URL}/#{url}"
    options[:login] = @username
    options[:password] = @password
    JSON::parse @api.get(url, options).body, symbolize_names: true
  end

end
