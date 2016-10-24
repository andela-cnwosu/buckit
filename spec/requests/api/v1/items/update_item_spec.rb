require "rails_helper"

RSpec.describe "Update Item", type: :request do
  describe "PUT #update" do
    let!(:item) do
      create :list
      create :item
    end

    it_behaves_like("unauthorized", "put", "/api/v1/bucketlists/1/items/1")
    it_behaves_like("not found", "put", "/api/v1/bucketlists/1/items/3")
    it_behaves_like("invalid params", "put", "/api/v1/bucketlists/1/items/1")
    it_behaves_like("invalid route", "put", "/api/v1/bucketlists/1/item/1")
    it_behaves_like("serializable", "put", "/api/v1/bucketlists/1/items/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "updates a bucket list item" do
        params = attributes_for(:item, :updated)
        put "/api/v1/bucketlists/1/items/1", params: params

        expect(response.status).to be(200)
        expect(Item.first.name).to eq("MyBucket")
      end
    end
  end
end
