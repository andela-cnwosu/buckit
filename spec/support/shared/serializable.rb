RSpec.shared_examples "serializable" do |method, action|
  include_context "doorkeeper oauth"

  before do
    send(method, action)
  end

  let!(:list_response){ json[:list] || json[:lists][0] }

  it "returns a date created key" do
    expect(list_response[:date_created]).to be_present
  end

  it "returns a json error message" do
    expect(list_response[:date_modified]).to be_present
  end
end