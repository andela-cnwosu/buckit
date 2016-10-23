require "rails_helper"

RSpec.describe "All Lists", type: :request do
  describe "GET #index" do
    let!(:lists) do
      user = User.first || create(:user)
      # create_list(:list_with_items, 5, user: user)
      5.times do |n|
        create(:list_with_items, user: user, name: "MyBucketList#{n}")
      end
    end

    context "when user has not provided the authorization code" do
      it_behaves_like("unauthorized", "get", "/api/v1/bucketlists")
    end

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"
      let!(:request) { get "/api/v1/bucketlists" }

      it "retrieves all bucket lists for the user" do
        expect(response.status).to be(200)
        expect(json.count).to eq(5)
        expect(json[0][:name]).to eq("MyBucketList0")
      end

      it "returns the item objects in each list" do
        json.each do |list_response|
          expect(list_response[:items]).to be_present
        end
      end
    end

    context "when user does not have any bucket list" do
      include_context "doorkeeper oauth"

      it "returns a json error message" do
        List.destroy_all
        get "/api/v1/bucketlists"

        expect(response.status).to be(204)
      end
    end

    context "when the route does not exist" do
      it_behaves_like("invalid route", "get", "/api/v1/bucketlist")
    end

    context "when the list objects are returned" do
      it_behaves_like("serializable", "get", "/api/v1/bucketlists")
    end
  end
end
