RSpec.shared_context "doorkeeper oauth", oauth: true do
  let!(:user) { User.first || create(:user) }
  let(:token) { double resource_owner_id: 1, acceptable?: true }

  before do
    allow_any_instance_of(Api::ApiController).to receive(:doorkeeper_token) {
      token
    }
  end
end
