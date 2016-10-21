require "rails_helper"

RSpec.describe "Update List", type: :request do
  describe "PUT #update" do
    let!(:list) { create :list }

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "put", "/api/v1/bucketlists/1")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "updates a bucket list" do
        put "/api/v1/bucketlists/1", params: {
          list: attributes_for(:list, :updated)
        }

        expect(response.status).to be(200)
        expect(List.first.name).to eq("MyBucket")
      end
    end

    context "when user provide invalid parameters" do
      it_behaves_like("invalid parameters", "put", "/api/v1/bucketlists/1")
    end

    context "when the bucket list does not exist" do
      it_behaves_like("missing parameters", "put", "/api/v1/bucketlists/3")
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "put", "/api/v1/bucketlist/1")
    end
  end
end
