require "rails_helper"

RSpec.describe "Update Item", type: :request do
  describe "PUT #update" do
    let!(:item) do
      create :list
      create :item
    end

    it_behaves_like("unauthorized user", "put", "/api/bucketlists/1/items/1")
    it_behaves_like("no found resource", "put", "/api/bucketlists/1/items/3")
    it_behaves_like("invalid params", "put", "/api/bucketlists/1/items/1")
    it_behaves_like("invalid route", "put", "/api/bucketlists/1/item/1")
    it_behaves_like("serialized resource", "put", "/api/bucketlists/1/items/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "updates a bucket list item" do
        params = attributes_for(:item, :updated)
        put "/api/bucketlists/1/items/1", params: params

        expect(response.status).to be(200)
        expect(Item.first.name).to eq("MyBucket")
      end
    end
  end
end
