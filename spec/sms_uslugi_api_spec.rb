require "spec_helper"

describe SmsUslugiApi do
  before do
    @sms = SmsUslugiApi.new("demo", "demo") # Changed in VCR
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
          account: "583.12",
          ocode: "80009999999",
          tarif: "Аванс::50",
          price: "0.50",
          source: ["systemTest", "Ded Moroz"],
          receive_numbers: [
            "79029999999",
            "79028888888"
          ]
        )
      end
    end
  end

  describe "sms sending" do
    it "should send sms" do
      VCR.use_cassette("send") do
        status = @sms.send("Тестовое сообщение", "81111111111", nil, "79021111111")
        expect(status).to include(
          code: 1,
          descr: "Успешно обработано",
          colsmsOfSending: 1,
          priceOfSending: '0.50'
        )
      end
    end
  end

end
