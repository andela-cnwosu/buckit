require "rails_helper"

RSpec.describe "Delete Item", type: :request do
  describe "DESTROY #destroy" do
    let!(:item) do
      create :list
      create :item
    end

    it_behaves_like("unauthorized", "delete", "/api/v1/bucketlists/1/items/1")
    it_behaves_like("not found", "delete", "/api/v1/bucketlists/1/items/3")
    it_behaves_like("invalid route", "delete", "/api/v1/bucketlists/1/item/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        delete "/api/v1/bucketlists/1/items/1"

        expect(response.status).to be(204)
        expect(Item.first).to be_nil
      end
    end
  end
end
