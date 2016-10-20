require 'rails_helper'

RSpec.describe "Show List", type: :request do
  describe 'GET #show' do
    let!(:list) { create :list }

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "get", "/api/v1/bucketlists/1")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "creates a bucket list" do
        get "/api/v1/bucketlists/1", params: {
          list: attributes_for(:updated_list)
        }

        expect(response.status).to be(200)
        expect(List.first.name).to eq("MyBucket")
      end
    end

    context "when user provide invalid parameters" do
      it_behaves_like("invalid parameters", "get", "/api/v1/bucketlists/1")
    end
  end
end
