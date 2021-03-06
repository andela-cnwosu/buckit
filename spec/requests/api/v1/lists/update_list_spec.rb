require "rails_helper"

RSpec.describe "Update List", type: :request do
  describe "PUT #update" do
    let!(:list) { create :list }

    it_behaves_like("unauthorized user", "put", "/api/bucketlists/1")
    it_behaves_like("invalid params", "put", "/api/bucketlists/1")
    it_behaves_like("no found resource", "put", "/api/bucketlists/3")
    it_behaves_like("invalid route", "put", "/api/bucketlist/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "updates a bucket list" do
        put "/api/bucketlists/1", params: attributes_for(:list, :updated)

        expect(response.status).to be(200)
        expect(List.first.name).to eq("MyBucket")
      end
    end
  end
end
