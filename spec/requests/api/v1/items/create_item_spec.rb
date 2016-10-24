require "rails_helper"

RSpec.describe "Create Item", type: :request do
  describe "POST #create" do
    let!(:list) { create :list }

    it_behaves_like("unauthorized", :post, "/api/v1/bucketlists/1/items")
    it_behaves_like("invalid params", "post", "/api/v1/bucketlists/1/items")
    it_behaves_like("invalid route", "post", "/api/v1/bucketlist/1/items")
    it_behaves_like("serializable", "post", "/api/v1/bucketlists/1/items")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list item" do
        params = attributes_for(:item, list: list)
        post "/api/v1/bucketlists/1/items", params: params

        expect(Item.first.name).to eq("MyBucketItem")
        expect(response.status).to be(201)
        expect(json[:name]).to include(Item.first.name)
      end
    end
  end
end
