require "rails_helper"

RSpec.describe "Update List", type: :request do
  describe "PUT #update" do
    let!(:list) { create :list }

    it_behaves_like("unauthorized", "put", "/api/v1/bucketlists/1")
    it_behaves_like("invalid params", "put", "/api/v1/bucketlists/1")
    it_behaves_like("not found", "put", "/api/v1/bucketlists/3")
    it_behaves_like("invalid route", "put", "/api/v1/bucketlist/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "updates a bucket list" do
        put "/api/v1/bucketlists/1", params: attributes_for(:list, :updated)

        expect(response.status).to be(200)
        expect(List.first.name).to eq("MyBucket")
      end
    end
  end
end
