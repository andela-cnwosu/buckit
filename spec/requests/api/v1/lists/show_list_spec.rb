require "rails_helper"

RSpec.describe "Show List", type: :request do
  describe "GET #show" do
    let!(:list) { create :list_with_items }

    it_behaves_like("unauthorized", "get", "/api/v1/bucketlists/1")
    it_behaves_like("not found", "get", "/api/v1/bucketlists/3")
    it_behaves_like("invalid route", "get", "/api/v1/bucketlist/1")
    it_behaves_like("serializable", "get", "/api/v1/bucketlists/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"
      let!(:request) { get "/api/v1/bucketlists/1" }

      it "retrieves a bucket list" do
        expect(response.status).to be(200)
        expect(json[:name]).to eq("MyBucketList")
      end

      it "embeds the item to the list" do
        expect(json[:items][0][:name]).to eq(list.items.first.name)
      end
    end
  end
end
