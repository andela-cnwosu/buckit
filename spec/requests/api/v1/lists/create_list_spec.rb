require "rails_helper"

RSpec.describe "Create List", type: :request do
  describe "POST #create" do
    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "post", "/api/v1/bucketlists")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        post "/api/v1/bucketlists", params: attributes_for(:list)

        expect(List.first.name).to eq("MyBucketList")
        expect(response.status).to be(201)
        expect(json["name"]).to include(List.first.name)
      end
    end

    context "when user provide invalid parameters" do
      it_behaves_like("invalid parameters", "post", "/api/v1/bucketlists")
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "post", "/api/v1/bucketlist")
    end
  end
end
