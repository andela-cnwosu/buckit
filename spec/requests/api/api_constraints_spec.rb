require "spec_helper"

describe ApiConstraints do
  let(:api_constraints_v1) { ApiConstraints.new(version: 1, default: true) }
  let(:host) { "localhost:3000" }
  let(:header) { { accept: "application/vnd.localhost; version=1" } }

  describe "matches?" do
    it "returns true when the version matches the 'Accept' header" do
      request = double(host: host, headers: header)

      expect(api_constraints_v1.matches?(request)).to be_true
    end

    it "returns the default version when 'default' option is specified" do
      request = double(host: host)

      expect(api_constraints_v1.matches?(request)).to be_true
    end
  end
end
