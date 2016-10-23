RSpec.shared_examples "serializable" do |method, action|
  include_context "doorkeeper oauth"

  before do
    params = attributes_for(:item)
    send(method, action, params: params)
  end

  let!(:list_response) { json[0] || json }

  it "returns a date created key" do
    expect(list_response[:date_created]).to be_present
  end

  it "returns a json error message" do
    expect(list_response[:date_modified]).to be_present
  end
end