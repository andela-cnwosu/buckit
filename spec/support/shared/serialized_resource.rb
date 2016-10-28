RSpec.shared_examples "serialized resource" do |method, action|
  include_context "doorkeeper oauth"

  before do
    params = attributes_for(:item)
    send(method, action, params: params)
  end

  let!(:resource_response) { json[0] || json }

  context "when the list object is returned" do
    it "displays a date_created key" do
      expect(resource_response[:date_created]).to be_present
    end

    it "displays a date_modified key" do
      expect(resource_response[:date_modified]).to be_present
    end
  end
end
