require "rails_helper"

RSpec.describe "Create Item", type: :request do
  describe "POST #create" do
    let!(:list) { create :list }

    it_behaves_like("unauthorized user", :post, "/api/bucketlists/1/items")
    it_behaves_like("invalid params", "post", "/api/bucketlists/1/items")
    it_behaves_like("invalid route", "post", "/api/bucketlist/1/items")
    it_behaves_like("serialized resource", "post", "/api/bucketlists/1/items")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list item" do
        params = attributes_for(:item, list: list)
        post "/api/bucketlists/1/items", params: params

        expect(Item.first.name).to eq("MyBucketItem")
        expect(response.status).to be(201)
        expect(json[:name]).to include(Item.first.name)
      end
    end
  end
end
