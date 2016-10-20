require 'rails_helper'

RSpec.describe "All Lists", type: :request do
  describe 'GET #index' do
    let!(:lists) do
      user = create(:user, email: Faker::Internet.email)
      create_list(:list, 5, user: user)
    end

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "get", "/api/v1/bucketlists")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"

      it "retrieves a bucket list" do
        get "/api/v1/bucketlists/1"

        expect(response.status).to be(200)
        expect(json["name"]).to eq("MyBucketList")
      end
    end

    context "when user does not have any bucketlist" do
      include_context "doorkeeper oauth"

      it "returns a json error message" do
        List.destroy_all
        get "/api/v1/bucketlists"

        expect(response.status).to be(422)
        expect(json["error"]).to eq(resources_not_exist_message)
      end
      it_behaves_like("missing parameters", "get", "/api/v1/bucketlists/3")
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "get", "/api/v1/bucketlist/1")
    end
  end
end
