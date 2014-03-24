# encoding: UTF-8
require "spec_helper"

file_path = File.join(File.expand_path(File.dirname(__FILE__)), 'settings.yml')
settings = YAML.load_file(file_path)['settings'] if File.file?(file_path)
settings ||= {}

describe SmsUslugiApi do
  before do
    @sms = SmsUslugiApi.new("#{settings['login']}", "#{settings['password']}") # Changed in VCR
  end

  describe "minimal functionality" do
    it "should instantiate class" do
      expect(@sms).to be_an_instance_of(SmsUslugiApi)
    end
  end

  describe "account info" do
    it "should get account info" do
      VCR.use_cassette("info") do
        info = @sms.info
        expect(info).to include(
          code: 1,
          descr: "Операция завершена успешно",
          account: "30.99",
          ocode: "#{settings['source']}",
          tarif: "Аванс::67",
          price: "0.67",
          source: ["systemTest"],
          receive_numbers: [

          ]
        )
      end
    end
  end

  describe "sms sending" do
    it "should send sms to me" do
      VCR.use_cassette("send_me") do
        status = @sms.send("Тестовое сообщение", "#{settings['phone_me']}", idGroup: nil, source: nil, onlydelivery: '1')
        expect(status).to include(
          code: 1,
          descr: "Успешно обработано",
          colsmsOfSending: 1,
          priceOfSending: "0.67"
        )
      end
    end

    it "should send sms to nw" do
      VCR.use_cassette("send_nw") do
        status = @sms.send("Тестовое сообщение", "#{settings['phone_nw']}", idGroup: nil, source: nil, onlydelivery: '1')
        expect(status).to include(
          code: 1,
          descr: "Успешно обработано",
          colsmsOfSending: 1,
          priceOfSending: "0.67"
        )
      end
    end

    it "should send sms to pr" do
      VCR.use_cassette("send_pr") do
        status = @sms.send("Тестовое сообщение", "#{settings['phone_pr']}", idGroup: nil, source: nil, onlydelivery: '1')
        expect(status).to include(
          code: 1,
          descr: "Успешно обработано",
          colsmsOfSending: 1,
          priceOfSending: "0.67"
        )
      end
    end
  end

  describe "phone number info" do
    it "should reveice phone number info" do
      VCR.use_cassette("getPhoneInfo") do
        phone_info = @sms.get_phone_info("#{settings['phone_me']}")
        expect(phone_info).to include(
          code: 1,
          descr: "Операция завершена успешно",
          phone: "#{settings['phone_me']}",
          country: "Россия",
          district: "#{settings['my_region']}",
          opsos: "#{settings['my_operator']} (цифровая подпись)"
        )
      end
    end
  end

end
