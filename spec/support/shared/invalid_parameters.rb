RSpec.shared_examples "invalid parameters" do |method, action|
  include_context "doorkeeper oauth"

  it "returns a json error message" do
    params = { list: attributes_for(:list, :invalid)}
    send(method, action, params: params)

    expect(json["error"]).to include("Name can't be blank")
  end
end