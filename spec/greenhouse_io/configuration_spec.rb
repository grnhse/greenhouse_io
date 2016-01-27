require 'spec_helper'

describe Greenhouse::Configuration do
  after { restore_default_config }

  context "when no symbolize_keys is specified" do
    before do
      restore_default_config
    end

    it "returns the default value" do
      expect(Greenhouse.configuration.symbolize_keys).to be false
    end
  end

  context "when given a symbolize_keys value" do
    before do
      Greenhouse.configure do |config|
        config.symbolize_keys = true
      end
    end

    it "returns the specified value" do
      expect(Greenhouse.configuration.symbolize_keys).to be true
    end
  end

  context "when no organization is specified" do
    before do
      restore_default_config
    end

    it "returns nil" do
      expect(Greenhouse.configuration.organization).to be_nil
    end
  end

  context "when given an organization" do
    before do
      Greenhouse.configure do |config|
        config.organization = "General Assembly"
      end
    end

    it "returns the specified value" do
      expect(Greenhouse.configuration.organization).to eq("General Assembly")
    end
  end

  context "when no api token is specified" do
    before do
      restore_default_config
    end

    it "returns nil" do
      expect(Greenhouse.configuration.api_token).to be_nil
    end
  end

  context "when given an api token" do
    before do
      Greenhouse.configure do |config|
        config.api_token = '123FakeToken'
      end
    end

    it "returns the specified value" do
      expect(Greenhouse.configuration.api_token).to eq('123FakeToken')
    end
  end
end