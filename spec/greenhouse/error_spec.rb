require 'spec_helper'

describe Greenhouse::Error do

  describe "#inspect" do

    context "when http error code is present" do
      it "creates an error with the code" do
        http_error = Greenhouse::Error.new(nil, 404)
        expect(http_error.code).to eq(404)
        expect(http_error.inspect).to eq("Greenhouse::Error: 404 response from server")
      end
    end

    context "when its an internal gem error" do
      it "creates an error with a message" do
        gem_error = Greenhouse::Error.new("organization can't be blank", nil)
        expect(gem_error.message).to eq("organization can't be blank")
        expect(gem_error.inspect).to eq("Greenhouse::Error: organization can't be blank")
      end
    end

  end

end
