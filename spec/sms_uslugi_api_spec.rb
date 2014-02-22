require 'spec_helper'

describe SmsUslugiApi do
  before do
    @sms = SmsUslugiApi.new("login", "password")
  end

  it "should instantiate class" do
    expect(@sms).to be_an_instance_of(SmsUslugiApi)
  end
end
