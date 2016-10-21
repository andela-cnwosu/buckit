require "rails_helper"

RSpec.describe "Delete Item", type: :request do
  describe "DESTROY #destroy" do
    let!(:item) do
      create :list
      create :item
    end

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "delete", "/api/v1/bucketlists/1/items/1")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        delete "/api/v1/bucketlists/1/items/1"

        expect(response.status).to be(204)
        expect(Item.first).to be_nil
      end
    end

    context "when the bucketlist does not exist" do
      route = "/api/v1/bucketlists/1/items/3"
      it_behaves_like("missing parameters", "delete", route)
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "delete", "/api/v1/bucketlists/1/item/1")
    end
  end
end
