RSpec.shared_examples "unauthorized user" do |method, action|
  context "when user has not provided the authorization code" do
    it "returns an authorization error response" do
      params = attributes_for(:item)
      send(method, action, params: params)

      expect(response.status).to be(401)
    end
  end
end
