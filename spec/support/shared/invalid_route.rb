RSpec.shared_examples "invalid route" do |method, action|
  include_context "doorkeeper oauth"

  before do 
    send(method, action)
  end

  it 'responds with 404' do
    expect(response.status).to eq(404)
  end

  it 'responds with error' do
    expect(json["error"]).to eq(route_not_exist_message)
  end
end  