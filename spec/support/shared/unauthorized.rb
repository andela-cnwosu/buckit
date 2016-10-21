RSpec.shared_examples "unauthorized" do |method, action|
  it "returns an authorization error response" do
    params = { list: attributes_for(:list), id: 1 }
    send(method, action, params: params)

    expect(response.status).to be(401)
  end
end
