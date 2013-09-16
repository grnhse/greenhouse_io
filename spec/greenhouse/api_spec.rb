require 'spec_helper'

describe Greenhouse::API do

  it "should have a base url for an API endpoint" do
    expect(Greenhouse::API.base_uri).to eq("https://api.greenhouse.io/v1")
  end

  context "given a Greenhouse::API client" do

    before do
      @client = Greenhouse::API.new('123FakeToken', organization: 'generalassembly')
    end

    describe "#initialize" do
      it "has an api_token" do
        expect(@client.api_token).to eq('123FakeToken')
      end

      it "has an organization" do
        expect(@client.organization).to eq('generalassembly')
      end

      it "uses an enviroment variable when token is not specified" do
        ENV['GREENHOUSE_API_TOKEN'] = '123FakeENV'
        default_client = Greenhouse::API.new
        expect(default_client.api_token).to eq('123FakeENV')
      end
    end

    context "when an organization has not been set" do
      it "raises an 'organization can't be blank' error" do
        no_org_client = Greenhouse::API.new
        expect{no_org_client.offices}.to raise_error(Greenhouse::Error)
      end
    end

    describe "#offices" do
      it "grabs the latest jobs and departments for an organization by each office" do
        VCR.use_cassette('offices') do
          expect(@client.offices).to_not be_nil
        end
      end
    end

    describe "#office" do
      it "grabs the latest jobs and deparments for a specific office" do
        VCR.use_cassette('office') do
          expect(@client.office(0)).to_not be_nil
        end
      end
    end

    describe "#departments" do
      it "returns a list of an organization's departments and jobs" do
        VCR.use_cassette('departments') do
          expect(@client.departments).to_not be_nil
        end
      end
    end

    describe "#department" do
      it "returns a list of jobs for a specific department" do
        VCR.use_cassette('department') do
          expect(@client.department(187)).to_not be_nil
        end
      end
    end

    describe "#jobs" do
      it "returns the list of all jobs" do
        VCR.use_cassette('jobs') do
          expect(@client.jobs).to_not be_nil
        end
      end

      it "returns a list of jobs and their job descriptions" do
        VCR.use_cassette('jobs_with_content') do
          expect(@client.jobs(:content => true)).to_not be_nil
        end
      end
    end

    describe "#job" do
      it "returns the details for a specific job by ID" do
        VCR.use_cassette('job') do
          expect(@client.job(721)).to_not be_nil
        end
      end

      it "returns the details for a specific job and its application questions" do
        VCR.use_cassette('job_with_questions') do
          expect(@client.job(721, :questions => true)).to_not be_nil
        end
      end
    end

    describe "#apply_to_job" do
      it "posts an application to a specified job" do
        VCR.use_cassette('apply_to_job') do
          expect(@client.apply_to_job(
            {
              :id => 721,
              :first_name => 'Richard',
              :last_name => 'Feynman',
              :email => 'richard123@test.ga.co'
            }
          )).to_not be_nil
        end
      end
    end

  end

end
