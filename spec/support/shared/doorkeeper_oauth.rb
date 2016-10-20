RSpec.shared_context "doorkeeper oauth", oauth: true do
  let(:token) { double resource_owner_id: 1, acceptable?: true }

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end
end