RSpec.shared_examples "invalid params" do |method, action|
  include_context "doorkeeper oauth"

  context "when user provide invalid params" do
    it "returns a json error message" do
      params = attributes_for(:item, :invalid)
      send(method, action, params: params)

      expect(json[:error][0]).to include("can't be blank")
    end
  end
end
