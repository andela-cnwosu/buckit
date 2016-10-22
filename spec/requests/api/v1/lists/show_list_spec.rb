require "rails_helper"

RSpec.describe "Show List", type: :request do
  describe "GET #show" do
    let!(:list) { create :list }

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "get", "/api/v1/bucketlists/1")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "retrieves a bucket list" do
        get "/api/v1/bucketlists/1"

        expect(response.status).to be(200)
        expect(json[:name]).to eq("MyBucketList")
      end

      it "embeds the item to the list" do
        expect(json[:list][:item][:name]).to eq(list.item.name)
      end
    end

    context "when the bucketlist does not exist" do
      it_behaves_like("missing parameters", "get", "/api/v1/bucketlists/3")
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "get", "/api/v1/bucketlist/1")
    end

    context "when the list object is returned" do
      it_behaves_like("serializable", "get", "/api/v1/bucketlists/1")
    end
  end
end
