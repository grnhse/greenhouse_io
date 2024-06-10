require 'spec_helper'

describe GreenhouseIo::Applications do
  before do
    GreenhouseIo.configuration.symbolize_keys = true
    @client = GreenhouseIo::Client.new(FAKE_API_TOKEN)
  end

  describe "#applications" do
    context "given no id" do
      before do
        VCR.use_cassette('client/applications') do
          @applications = @client.applications
        end
      end

      it "returns a response" do
        expect(@applications).to_not be_nil
      end

      it "returns an array of applications" do
        expect(@applications).to be_an_instance_of(Array)
      end

      it "returns application details" do
        expect(@applications.first).to have_key(:person_id)
      end
    end

    context "given an id" do
      before do
        VCR.use_cassette('client/application') do
          @application = @client.applications(1)
        end
      end

      it "returns a response" do
        expect(@application).to_not be_nil
      end

      it "returns an application hash" do
        expect(@application).to be_an_instance_of(Hash)
      end

      it "returns an application's details" do
        expect(@application).to have_key(:person_id)
      end
    end

    context "given a job_id" do
      before do
        VCR.use_cassette('client/application_by_job_id') do
          @applications = @client.applications(nil, :job_id => 144371)
        end
      end

      it "returns a response" do
        expect(@applications).to_not be_nil
      end

      it "returns an array of applications" do
        expect(@applications).to be_an_instance_of(Array)
        expect(@applications.first).to be_an_instance_of(Hash)
        expect(@applications.first).to have_key(:prospect)
      end
    end
  end
end
