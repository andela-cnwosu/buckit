RSpec.shared_examples "missing parameters" do |method, action|
  include_context "doorkeeper oauth"

  before do 
    send(method, action)
  end

  it 'responds with 422' do
    expect(response.status).to eq(422)
  end

  it 'returns a json error message' do
    expect(json["error"]).to eq(resource_not_exist_message)
  end
end  