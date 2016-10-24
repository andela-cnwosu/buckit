RSpec.shared_examples "serializable" do |method, action|
  include_context "doorkeeper oauth"

  before do
    params = attributes_for(:item)
    send(method, action, params: params)
  end

  let!(:list_response) { json[0] || json }

  context "when the list object is returned" do
    it "displays a date_created key" do
      expect(list_response[:date_created]).to be_present
    end

    it "displays a date_modified key" do
      expect(list_response[:date_modified]).to be_present
    end
  end
end
