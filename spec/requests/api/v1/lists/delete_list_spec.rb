require "rails_helper"

RSpec.describe "Delete List", type: :request do
  describe "DELETE #destroy" do
    let!(:list) { create :list }

    it_behaves_like("unauthorized user", "delete", "/api/bucketlists/1")
    it_behaves_like("no found resource", "delete", "/api/bucketlists/3")
    it_behaves_like("invalid route", "delete", "/api/bucketlist/1")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "deletes a bucket list" do
        delete "/api/bucketlists/1"

        expect(response.status).to be(200)
        expect(List.first).to be_nil
      end
    end
  end
end
