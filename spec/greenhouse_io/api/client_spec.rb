require 'spec_helper'

describe GreenhouseIo::Client do

  it "should have a base url for an API endpoint" do
    expect(GreenhouseIo::Client.base_uri).to eq("https://harvest.greenhouse.io/v1")
  end

  context "given an instance of GreenhouseIo::Client" do

    before do
      @client = GreenhouseIo::Client.new('123FakeToken')
    end

    describe "#initialize" do
      it "has an api_token" do
        expect(@client.api_token).to eq('123FakeToken')
      end

      it "uses an enviroment variable when token is not specified" do
        ENV['GREENHOUSE_API_TOKEN'] = '123FakeENV'
        default_client = GreenhouseIo::Client.new
        expect(default_client.api_token).to eq('123FakeENV')
      end
    end

  end
end
