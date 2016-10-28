require "rails_helper"

RSpec.describe "All Lists", type: :request do
  describe "GET #index" do
    let!(:lists) do
      user = User.first || create(:user)
      25.times do |n|
        create(:list_with_items, user: user, name: "MyBucketList#{n}")
      end
    end

    it_behaves_like("unauthorized user", "get", "/api/bucketlists")
    it_behaves_like("invalid route", "get", "/api/bucketlist")
    it_behaves_like("serialized resource", "get", "/api/bucketlists")

    context "when user has provided the authorization code" do
      include_context "doorkeeper oauth"
      let!(:request) { get "/api/bucketlists" }

      it "retrieves all bucket lists for the user limited by page" do
        expect(response.status).to be(200)
        expect(json.count).to eq(20)
        expect(json[0][:name]).to eq("MyBucketList0")
      end

      it "returns the item objects in each list" do
        json.each do |list_response|
          expect(list_response[:items]).to be_present
        end
      end

      it "returns the lists objects by page number and limit" do
        get "/api/bucketlists?page=9&limit=3"

        expect(json.count).to eq(1)
      end

      it "returns an error message if limit is not in the valid range" do
        get "/api/bucketlists?page=1&limit=101"
        message = paginate_limit_error

        expect(json[:error]).to eq(message)
      end

      it "retrieves a bucket list if a name is provided" do
        get "/api/bucketlists?q=MyBucketList5"

        expect(json.count).to eq(1)
        expect(json[0][:name]).to eq("MyBucketList5")
      end
    end

    context "when user does not have any bucket list" do
      include_context "doorkeeper oauth"

      it "returns a json error message" do
        List.destroy_all
        get "/api/bucketlists"

        expect(response.status).to be(404)
      end
    end
  end
end
