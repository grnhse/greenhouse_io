require 'spec_helper'

describe Greenhouse::API do

  it "should have a base url for an API endpoint" do
    expect(Greenhouse::API.base_uri).to eq("https://api.greenhouse.io/v1")
  end

  context "given a Greenhouse::API client" do

    before do
      @client = Greenhouse::API.new('123FakeToken', { organization: 'testOrganization' })
    end

    describe "#initialize" do
      it "has an api_token" do
        expect(@client.api_token).to eq('123FakeToken')
      end

      it "has an organization" do
        expect(@client.organization).to eq('testOrganization')
      end

      it "uses an enviroment variable when token is not specified" do
        ENV['GREENHOUSE_API_TOKEN'] = '123FakeENV'
        default_client = Greenhouse::API.new
        expect(default_client.api_token).to eq('123FakeENV')
      end
    end

  end

end
