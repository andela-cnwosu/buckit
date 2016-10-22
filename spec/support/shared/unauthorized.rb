RSpec.shared_examples "unauthorized" do |method, action|
  it "returns an authorization error response" do
    params = attributes_for(:item)
    send(method, action, params: params)

    expect(response.status).to be(401)
  end
end
