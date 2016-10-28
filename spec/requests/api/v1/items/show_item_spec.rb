require "rails_helper"

RSpec.describe "Show List", type: :request do
  describe "GET #show" do
    let!(:item) do
      list = create :list
      create(:item, list: list)
    end

    it_behaves_like("unauthorized user", "get", "/api/bucketlists/1/items/1")
    it_behaves_like("no found resource", "get", "/api/bucketlists/1/items/3")
    it_behaves_like("invalid route", "get", "/api/bucketlist/1/items/1")
    it_behaves_like("serialized resource", "get", "/api/bucketlists/1/items/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"
      let!(:request) { get "/api/bucketlists/1/items/1" }

      it "retrieves a bucket list item" do
        expect(response.status).to be(200)
        expect(json[:name]).to eq("MyBucketItem")
      end
    end
  end
end
