require "spec_helper"
require "api_constraints"

describe "ApiConstraints" do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1, default: true) }
  let(:host) { "localhost:3000" }
  let(:header) { { accept: "application/vnd.localhost; version=1" } }
  let(:header_request) { double(host: host, headers: header) }

  describe "matches?" do
    context "when the version matches the 'Accept' header" do
      it "returns true" do
        expect(api_constraints_v1.matches?(header_request)).to be_truthy
      end
    end

    context "when the version does not match the 'Accept' header" do
      context "when no option is specified" do
        it "returns true" do
          request = double(host: host)

          expect(api_constraints_v1.matches?(request)).to be_truthy
        end
      end

      context "when 'default' option is not specified" do
        it "returns true" do
          constraint = ApiConstraints.new(version: 2)

          expect(constraint.matches?(header_request)).to be_falsey
        end
      end

      context "when 'default' option is specified" do
        it "returns true" do
          constraint = ApiConstraints.new(version: 2, default: true)

          expect(constraint.matches?(header_request)).to be_truthy
        end
      end
    end
  end
end
