require 'rails_helper'

RSpec.describe "Delete List", type: :request do
  describe 'DELETE #destroy' do
    let!(:list) { create :list }

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "delete", "/api/v1/bucketlists/1")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        delete "/api/v1/bucketlists/1"

        expect(response.status).to be(204)
        expect(List.first).to be_nil
      end
    end

    context "when the bucketlist does not exist" do
      it_behaves_like("missing parameters", "delete", "/api/v1/bucketlists/3")
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "delete", "/api/v1/bucketlist/1")
    end
  end
end
