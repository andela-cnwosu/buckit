require "rails_helper"

RSpec.describe "Create Item", type: :request do
  describe "POST #create" do
    let!(:list) { create :list }

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", :post, "/api/v1/bucketlists/1/items")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list item" do
        params = { item: attributes_for(:item), list: list }
        post "/api/v1/bucketlists/1/items", params: params

        expect(Item.first.name).to eq("MyBucketItem")
        expect(response.status).to be(201)
        expect(json["name"]).to include(Item.first.name)
      end
    end

    context "when user provide invalid parameters" do
      it_behaves_like("invalid parameters", "post", "/api/v1/bucketlists/1/items")
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "post", "/api/v1/bucketlist/1/items")
    end
  end
end
